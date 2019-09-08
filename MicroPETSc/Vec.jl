abstract type PetscVecBase <: AbstractVector{PetscScalar}
end

"""
    A PETSc Vec wrapper.
"""
mutable struct PetscVec <: PetscVecBase

    " The pointer to the PETSc Vec object "
    v::Ref{Vec}

    " Whether or not a size has been set by calling setSize() "
    sized::Bool

    " Whether or not the vector has ever been assembled (Note: the vector might currently NOT be assembled) "
    assembled::Bool

    name::String

    function PetscVec()
        println("Creating PetscVec")
        v = Ref{Vec}()
        ccall((:VecCreate, PETSC_LIB), PetscErrorCode, (comm_type, Ref{Vec}), MPI.COMM_WORLD, v)
        ccall((:VecSetType, PETSC_LIB), PetscErrorCode, (Vec, VecType), v[], VECMPI)
        new_vec = new(vec, false, false, "")

        function finalize(avec)
            ccall((:VecDestroy, PETSC_LIB), PetscErrorCode, (Ref{Vec},), avec.vec)
            println(avec.name)
        end

        finalizer(new_vec, finalize)

        return new_vec
    end

    function PetscVec(name::String)
        println("Creating ", name)
        new_vec = PetscVec()
        new_vec.name = name
        return new_vec
    end
end





"""
    Set up the size of a PetscVecBase

    Note: This MUST be called before setting/getting values!
"""
function setSize!(vec::PetscVecBase; n_local::PetscInt=PETSC_DECIDE, n_global::PetscInt=PETSC_DETERMINE)
    @assert !v.sized

    # Must provide _some_ size!
    @assert n_local != PETSC_DECIDE || n_global != PETSC_DETERMINE

    ccall((:VecSetSizes, PETSC_LIB), PetscErrorCode, (Vec, PetscInt, PetscInt), v.v[], n_local, n_global)

    v.sized = true
end

"""
    Must be called after setting/adding values to construct the vector
"""
function assemble!(v::PetscVecBase)
    @assert v.sized

    ccall((:VecAssemblyBegin, PETSC_LIB), PetscErrorCode, (Vec,), v.v[])
    ccall((:VecAssemblyEnd, PETSC_LIB), PetscErrorCode, (Vec,), v.v[])

    v.assembled = true
end



"""
    Use PETSc viewer to print out the vector
"""
function viewVec(vec::PetscVecBase)
    @assert vec.sized
    @assert vec.assembled

    viewer = ccall((:PETSC_VIEWER_STDOUT_, PETSC_LIB), PetscViewer, (comm_type,), MPI.COMM_WORLD)
    ccall((:VecView, PETSC_LIB), PetscErrorCode, (Vec, PetscViewer), vec.vec[], viewer)
end

"""
    Does vec[i] += v
"""
function plusEquals!(vec::PetscVecBase, v::Array{Float64}, i)
    i_ind = (PetscInt)[i_val-1 for i_val in i]

    @assert length(v) == length(i_ind)

    ccall((:VecSetValues, PETSC_LIB), PetscErrorCode, (Vec, PetscInt, Ptr{PetscInt}, Ptr{PetscScalar}, InsertMode), vec.vec[], length(i_ind), i_ind, v, ADD_VALUES)
end

"""
    If the incoming type is not a float, make it so

    Does vec[i] += v
"""
function plusEquals!(vec::PetscVecBase, v::Array{T}, i) where T
    plusEquals!(vec, (Float64)[(Float64)(val) for val in v], i)
end

"""
    vec += v
"""
function plusEquals!(vec::PetscVecBase, v::PetscVecBase)
    ccall((:VecAXPY, PETSC_LIB), PetscErrorCode, (Vec, PetscScalar, Vec), vec.vec[], 1.0, v.vec[])
end

"""
    vec = 0
"""
function zero!(vec::PetscVecBase)
    ccall((:VecZeroEntries, PETSC_LIB), PetscErrorCode, (Vec,), vec.vec[])
end

"""
    vec = a*vec
"""
function scale!(vec::PetscVecBase, a::Real)
    ccall((:VecScale, PETSC_LIB), PetscErrorCode, (Vec, PetscScalar), vec.vec[], (PetscScalar)(a))
end

import Base.copy!

"""
    vec = a
"""
function copy!(vec::PetscVecBase, a::PetscVecBase)
    # NOTE!  PETSc's calling sequence is _backwards_ from Julia!
    # The destination is the _second_ argument for PETSc
    ccall((:VecCopy, PETSC_LIB), PetscErrorCode, (Vec, Vec), a.vec[], vec.vec[])
end



import Base.similar
"""
    Creates a PetscVec() with the same storage as the passed in vector
"""
function similar(vec::PetscVec)
    new_vec = PetscVec()

    ccall((:VecDuplicate, PETSC_LIB), PetscErrorCode, (Vec, Ref{Vec}), vec.vec[], new_vec.vec)

    return new_vec
end

import LinearAlgebra.norm
"""
    L2 Norm
"""
function norm(vec::PetscVecBase)
    norm_value = Ref{PetscScalar}()

    ccall((:VecNorm, PETSC_LIB), PetscErrorCode, (Vec, NormType, Ref{PetscScalar}), vec.vec[], NORM_2, norm_value)

    return norm_value[]
end

"""
    Serializes a parallel PETSc vec down into a Julia Array

    Only returns the array on processor 0
"""
function serializeToZero(vec::PetscVecBase)
    serialized_vec = PetscVec("serialized_vec")
    scatter = Ref{VecScatter}()

    ccall((:VecScatterCreateToZero, PETSC_LIB), PetscErrorCode, (Vec, Ref{VecScatter}, Ref{Vec}), vec.vec[], scatter, serialized_vec.vec)

    ccall((:VecScatterBegin, PETSC_LIB), PetscErrorCode, (VecScatter, Vec, Vec, InsertMode, ScatterMode), scatter[], vec.vec[], serialized_vec.vec[], INSERT_VALUES, SCATTER_FORWARD)
    ccall((:VecScatterEnd, PETSC_LIB), PetscErrorCode, (VecScatter, Vec, Vec, InsertMode, ScatterMode), scatter[], vec.vec[], serialized_vec.vec[], INSERT_VALUES, SCATTER_FORWARD)

    # Have to copy the array because _getArray is reference memory that PETSc will destroy in a moment
    serialized_array = copy(_getArray(serialized_vec))

    ccall((:VecScatterDestroy, PETSC_LIB), PetscErrorCode, (Ref{VecScatter},), scatter)
    ccall((:VecDestroy, PETSC_LIB), PetscErrorCode, (Ref{Vec},), serialized_vec.vec)

    return serialized_array
end

#### AbstractArray Interface Definitions ###

#import Base.linearindexing

"""
    PETSc Vectors are inherently 1D
"""
function linearindexing(vec::PetscVecBase)
    return Base.LinearFast()
end

import Base.size

"""
    Returns the _global_ size of the vector
"""
function size(vec::PetscVecBase)
    N = Ref{PetscInt}(0)

    ccall((:VecGetSize, PETSC_LIB), PetscErrorCode, (Vec, Ref{PetscInt}), vec.vec[], N)

    return (N[])
end

import Base.setindex!

"""
    Sets the value at i
"""
function setindex!(vec::PetscVecBase, v, i)
    # Copy out the values
    val = (Float64)[v_val for v_val in v]

    # Call the specialization below
    setindex!(vec, val, i)
end

"""
    Sets the value at i,j.

    Specialization for when v is already an array of Float64 (faster because we don't need to copy it)
"""
function setindex!(vec::PetscVecBase, v::Array{Float64}, i)
    i_ind = (PetscInt)[i_val-1 for i_val in i]

    @assert length(v) == length(i_ind)

    ccall((:VecSetValues, PETSC_LIB), PetscErrorCode, (Vec, PetscInt, Ptr{PetscInt}, Ptr{PetscScalar}, InsertMode), vec.vec[], length(i_ind), i_ind, v, INSERT_VALUES)
end

"""
    Don't do this
"""
function setindex!(vec::PetscVecBase, v, i, j)
    error("Attempt to index PetscVecBasetor using multiple dimensions!")
end

import Base.getindex

"""
    Don't do this either
"""
function getindex(vec::PetscVecBase, i, j)
    error("Attempt to index PetscVecBaseVector using multiple dimensions!")
end

"""
    Proper getter for entries from the vector for integer indices
"""
function getindex(vec::PetscVecBase, i::T) where {T<:Integer}
    # Don't forget about 1-based indexing...
    i_ind = (PetscInt)[i-1]

    get_vals = Array{Float64}(1)

    ccall((:VecGetValues, PETSC_LIB), PetscErrorCode, (Vec, PetscInt, Ptr{PetscInt}, Ref{PetscScalar}), vec.vec[], 1, i_ind, get_vals)

    return get_vals[1]
end

"""
    Proper getter for entries from the vector
"""
function getindex(vec::PetscVecBase, i)
    i_ind = (PetscInt)[i_val-1 for i_val in i]

    get_vals = Array{Float64}(length(i_ind))

    ccall((:VecGetValues, PETSC_LIB), PetscErrorCode, (Vec, PetscInt, Ptr{PetscInt}, Ref{PetscScalar}), vec.vec[], length(i_ind), i_ind, get_vals)

    return get_vals
end



########## Private stuff

"""
    PRIVATE: Used internally.  Don't use.
"""
function _getArray(vec::PetscVecBase)
    raw_data = Ref{Ptr{PetscScalar}}()
    ccall((:VecGetArray, PETSC_LIB), PetscErrorCode, (Vec, Ref{Ptr{PetscScalar}}), vec.vec[], raw_data)

    local_size = Ref{PetscInt}()
    ccall((:VecGetLocalSize, PETSC_LIB), PetscErrorCode, (Vec, Ref{PetscInt}), vec.vec[], local_size)

    return unsafe_wrap(Array, raw_data[], local_size[], false)
end



import Base.unsafe_convert

"""
    PRIVATE: Used internally.  Don't use.
"""
function _restoreArray(vec::PetscVecBase, raw_data::Array{PetscScalar})
    # This mess is required because PETSc is expecting a PetscScalar** and Julia won't automatically
    # convert the array to that
    pointer = Ref{Ptr{PetscScalar}}()
    pointer[] = unsafe_convert(Ptr{PetscScalar}, raw_data)
    ccall((:VecRestoreArray, PETSC_LIB), PetscErrorCode, (Vec, Ref{Ptr{PetscScalar}}), vec.vec[], pointer)
end

