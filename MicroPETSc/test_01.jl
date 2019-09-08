push!(LOAD_PATH, expanduser("."))

using MicroPETSc

function test_main()
    println("Hello")
    MicroPETSc._petsc_lib()

    v = PetscVec()
    setSize!(vec, n_local=(Int32)(4))
    #@test vec.sized
end

test_main()