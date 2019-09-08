"""
    A PETSc Vec wrapper for Ghosted Vectors.
"""
mutable struct GhostedPetscVec <: PetscVecBase

    " The pointer to the PETSc Vec object "
    v::Ref{Vec}

    " Whether or not a size has been set. "
    sized::Bool

    " Whether or not the vector has ever been assembled (Note: the vector might currently NOT be assembled) "
    assembled::Bool

    " Maps global indices to local indices "
    global_to_local_map::Dict{PetscInt, PetscInt}

    " The first index on this processor (1-based)"
    first_local_index::PetscInt

    " The last index on this processor (1-based)"
    last_local_index::PetscInt

    " Whether or not the raw array is present "
    raw_array_present::Bool

    " The raw local array.  This shouldn't be accessed directly!  Use [] to access values. (1-based)"
    raw_array::Array{PetscScalar}

    " The local form.  Only present if the raw_array is.  Only for internal use!"
    local_form::PetscVec

    function GhostedPetscVec{T}(ghosts::Array{T};
                                n_local::PetscInt=PETSC_DECIDE, n_global::PetscInt=PETSC_DETERMINE)
        vec = Ref{Vec}()
        ghost_dofs = (PetscInt)[dof-1 for dof in ghosts]
        ccall((:VecCreateGhost, PETSC_LIB), PetscErrorCode, (comm_type, PetscInt, PetscInt, PetscInt, Ptr{PetscInt}, Ref{Vec}),
              MPI.COMM_WORLD, n_local, n_global, length(ghost_dofs), ghost_dofs, vec)

        first = Ref{PetscInt}()
        last = Ref{PetscInt}()

        ccall((:VecGetOwnershipRange, PETSC_LIB), PetscErrorCode, (Vec, Ref{PetscInt}, Ref{PetscInt}), vec[], first, last)

        # +1 is for 1-based indexing
        new_vec = new(vec, true, false, Dict{PetscInt, PetscInt}(), first[]+1, last[], false)

        # Need to set up the global_to_local map
        for i in 1:length(ghosts)
            new_vec.global_to_local_map[ghosts[i]] = i + (last[]-first[])
        end

        # This idea comes from libMesh
        # mapping = Ref{ISLocalToGlobalMapping}()

        # ccall((:VecGetLocalToGlobalMapping, PETSC_LIB), PetscErrorCode, (Vec, Ref{ISLocalToGlobalMapping}), vec[], mapping)

        # println("mapping: ", mapping)

        # indices_ptr = Ref{Ptr{PetscInt}}()

        # ccall((:ISLocalToGlobalMappingGetIndices, PETSC_LIB), PetscErrorCode, (ISLocalToGlobalMapping, Ref{Ptr{PetscInt}}), mapping[], indices_ptr)

        # println("indices_ptr: ", indices_ptr)

        # mapping_size = Ref{PetscInt}()

        # ccall((:ISLocalToGlobalMappingGetSize, PETSC_LIB), PetscErrorCode, (ISLocalToGlobalMapping, Ref{PetscInt}), mapping[], mapping_size)

        # println("mapping_size: ", mapping_size)

        # indices = unsafe_wrap(Array, indices_ptr[], mapping_size[], false)

        # if MPI.Comm_rank(MPI.COMM_WORLD) == 0
        #     println("indices: ", indices)
        # end

        # for i in 1:length(indices)
        #     if indices[i]+1 < new_vec.first_local_index || new_vec.last_local_index < indices[i]+1
        #         new_vec.global_to_local_map[indices[i]+1] = i
        #     end
        # end

        # if MPI.Comm_rank(MPI.COMM_WORLD) == 0
        #     println(new_vec.global_to_local_map)
        # end

        # ccall((:ISLocalToGlobalMappingRestoreIndices, PETSC_LIB), PetscErrorCode, (ISLocalToGlobalMapping, Ref{Ptr{PetscInt}}), mapping[], indices_ptr)

        return new_vec
    end
end


"""
    vec = a when "vec" is a ghosted vec
"""
function copy!(vec::GhostedPetscVec, a::PetscVecBase)
    # Basic idea here: copy over the purely local data directly
    # then use assemble!() to update the ghosts

    # This happens in five steps
    # 1. Get the local form and array for the destination (vec)
    # 2. Get the array for the src (a)
    # 3. Copy local values
    # 4. Restore everything
    # 5. Call assemble!() to update ghosts

    # 1:
    local_and_ghosted_data_array = _getArray(vec)

    # 2:
    src_local_array = _getArray(a)

    @assert length(local_and_ghosted_data_array) >= length(src_local_array)

    # 3:
    for i in 1:length(src_local_array)
        local_and_ghosted_data_array[i] = src_local_array[i]
    end

    # 4:
    _restoreArray(a, src_local_array)
    _restoreArray(vec)

    # 5:
    assemble!(vec)
end


"""
    Helper function for ghosted vector indices
"""
function _getindices(vec::GhostedPetscVec, indices)
    raw_indices = Array{PetscInt}(length(indices))

    for i in 1:length(indices)
        index = indices[i]
        if vec.first_local_index <= index && index <= vec.last_local_index # Within the local portion of the vector
            raw_indices[i] = (index - vec.first_local_index) + 1
        else # Within the ghosted part
            raw_indices[i] = vec.global_to_local_map[index]
        end
    end

    return raw_indices
end

"""
    Proper getter for entries from the vector for integer indices for Ghosted Vectors
"""
function getindex{T<:Integer}(vec::GhostedPetscVec, i::T)
    if !vec.raw_array_present
        _getArray(vec)
    end

    return vec.raw_array[_getindices(vec, (PetscInt)[i])[1]]
end

"""
    Proper getter for entries from the vector for Ghosted Vectors
"""
function getindex(vec::GhostedPetscVec, i)
    if !vec.raw_array_present
        _getArray(vec)
    end

    return vec.raw_array[_getindices(vec, i)]
end

"""
    PRIVATE: Used internally.  Don't use.
"""
function _restoreArray(vec::GhostedPetscVec)
    if vec.raw_array_present
        _restoreArray(vec.local_form, vec.raw_array)
        ccall((:VecGhostRestoreLocalForm, PETSC_LIB), PetscErrorCode, (Vec, Ref{Vec}), vec.vec[], vec.local_form.vec)
        vec.raw_array_present = false
    end
end


"""
    Must be called after setting/adding values to construct the vector
"""
function assemble!(vec::GhostedPetscVec)
    @assert vec.sized

    _restoreArray(vec)

    ccall((:VecAssemblyBegin, PETSC_LIB), PetscErrorCode, (Vec,), vec.vec[])
    ccall((:VecAssemblyEnd, PETSC_LIB), PetscErrorCode, (Vec,), vec.vec[])

    ccall((:VecGhostUpdateBegin, PETSC_LIB), PetscErrorCode, (Vec, InsertMode, ScatterMode), vec.vec[], INSERT_VALUES, SCATTER_FORWARD)
    ccall((:VecGhostUpdateEnd, PETSC_LIB), PetscErrorCode, (Vec, InsertMode, ScatterMode), vec.vec[], INSERT_VALUES, SCATTER_FORWARD)

    vec.assembled = true
end


"""
    PRIVATE: Used internally.  Don't use.
"""
function _getArray(vec::GhostedPetscVec)
    if !vec.raw_array_present
        vec.local_form = PetscVec("local_form")
        ccall((:VecGhostGetLocalForm, PETSC_LIB), PetscErrorCode, (Vec, Ref{Vec}), vec.vec[], vec.local_form.vec)

        vec.raw_array = _getArray(vec.local_form)

        vec.raw_array_present = true
    end

    return vec.raw_array
end
