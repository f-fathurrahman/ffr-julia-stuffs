module MicroPETSc

import MPI

const PETSC_DIR = "/home/efefer/WORKS/PETSC/petsc-3.11.3/arch-linux2-c-debug"
const PETSC_LIB = joinpath(PETSC_DIR, "lib", "libpetsc.so")

function _petsc_lib()
    println("PETSC_LIB = ", PETSC_LIB)
end

include("PetscTypes.jl")

function finalize()
    ccall((:PetscFinalize, PETSC_LIB),
           PetscErrorCode,
           ()
    )
    MPI.Finalize()
end

function __init__()
    
    MPI.Init()
    
    args = vcat("julia", ARGS)
    nargs = length(args)
    
    err = ccall( (:PetscInitializeNoPointers, PETSC_LIB),
            PetscErrorCode,
            (Cint, Ptr{Ptr{UInt8}}, Cstring, Cstring),
            nargs, args, C_NULL, C_NULL
    )
    
    # Cleanup at the end
    atexit(finalize)
end

include("Vec.jl")
export PetscVec, setSize!, assemble!, viewVec, plusEquals!, zero!, scale!, serializeToZero

#=
abstract type PetscVecBase <: AbstractVector{PetscScalar}  end


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
        ccall((:VecCreate, library), PetscErrorCode, (comm_type, Ref{Vec}), MPI.COMM_WORLD, vec)
        ccall((:VecSetType, library), PetscErrorCode, (Vec, VecType), vec[], VECMPI)
        new_vec = new(vec, false, false, "")

        function finalize(avec)
            ccall((:VecDestroy, library), PetscErrorCode, (Ref{Vec},), avec.vec)
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
=#

end