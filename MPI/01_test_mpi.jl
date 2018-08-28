using Statistics

import MPI

function main()
    MPI.Init()
    comm = MPI.COMM_WORLD

    Nprocs  = MPI.Comm_size( comm )
    my_rank = MPI.Comm_rank( comm )

    println("Nprocs  = ", Nprocs)
    println("my_rank = ", my_rank)

    recv_mesg = zeros(100,1)

    if my_rank == 0
        send_mesg = ones(100,1)
        for i = 1:Nprocs-1
            MPI.Send( send_mesg, i, 0, comm )
        end
    else
        MPI.Recv!( recv_mesg, 0, 0, comm )
    end
    
    m = mean( recv_mesg, dims=1 )
    
    #sleep( my_rank*2 )
    
    println("Results of rank ", my_rank, ": ", m)
    
    MPI.Barrier( comm )
    MPI.Finalize()
end

main()

