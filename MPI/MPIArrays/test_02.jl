push!(LOAD_PATH, ".")

using MPI, MPIArrays

function main()
    MPI.Init()
    my_rank = MPI.Comm_rank(MPI.COMM_WORLD)

    println("my_rank = ", my_rank)
    
    N = 10

    A = MPIArray{Float64}(N,N)
    x = MPIArray{Float64}(N)
    y = MPIArray{Float64}(N)
    z = MPIArray{Float64}(N)

    forlocalpart!( m -> fill!(m, my_rank+0.1), x )
    forlocalpart!( m -> fill!(m, my_rank+0.1), A )

    sync(A, x)

    if my_rank == 0
        println("Hello")
        #println(x)
    end

    z = A * x
    forlocalpart!( m -> m .+ 1, x )

    if my_rank == 0
        println(x)
        println(typeof(x))
        println(typeof(z))
    end

    free(x)
    free(y)
    MPI.Finalize()
end

main()
