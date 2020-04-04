push!(LOAD_PATH, ".")

using MPI, MPIArrays

function main()
    MPI.Init()
    rank = MPI.Comm_rank(MPI.COMM_WORLD)
    N = 5000 # size of the matrix

    # Create an uninitialized matrix and vector
    x = MPIArray{Float64}(N)
    A = MPIArray{Float64}(N,N)

    # Set random values
    forlocalpart!(m -> fill!(m,1.0),x)
    forlocalpart!(m -> fill!(m,1.1),A)

    # Make sure every process finished initializing the coefficients
    sync(A, x)

    b = A * x
    #for i in 1:100
    #    b = A*x
    #end

    # This will print on the first process, using slow element-by-element communication, but that's OK to print to screen
    #rank == 0 && println("Matvec result: $b")

    #rank == 0 && println("typeof(b) = ", typeof(b))

    # Clean up
    free(A)
    free(x)
    MPI.Finalize()
end

main()