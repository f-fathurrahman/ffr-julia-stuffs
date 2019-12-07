using Printf
import MPI

const PETSC_DIR = "/opt/petsc-3.11.3_openmpi-2.2.1_debug"
const PETSC_LIB = joinpath(PETSC_DIR, "lib", "libpetsc.so")

const PetscErrorCode = Cint

function main()

    MPI.Init()

    args = vcat("julia", ARGS)
    Nargs = length(args)

    println("ARGS = ", ARGS)
    @printf("Nargs = %d\n", Nargs)

    err = ccall( (:PetscInitializeNoPointers, PETSC_LIB),
            PetscErrorCode,
            (Cint, Ptr{Ptr{UInt8}}, Cstring, Cstring),
            Nargs, args, C_NULL, C_NULL
    )
    println("err = ", err)

    err = ccall( (:PetscFinalize, PETSC_LIB), PetscErrorCode, () )

    println("err = ", err)

    MPI.Finalize()

end

main()