push!(LOAD_PATH, ".")

using MPI, MPIArrays

function main()
    MPI.Init()
    my_rank = MPI.Comm_rank(MPI.COMM_WORLD)
    N = 8

    x = MPIArray{Float64}(N)
    forlocalpart!( m -> fill!(m, my_rank+0.1), x )

    if my_rank == 0
        #display(x); println()
        display(x.localarray); println()
    end
        
    free(x)
    MPI.Finalize()
end

main()