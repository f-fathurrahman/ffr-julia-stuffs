using LinearAlgebra

function do_loop( Ns::Int64, cutoff::Float64 )
    v1 = rand(3,Ns)
    Ng = 0
    for k = 1:Ns
        @inbounds G = dot( v1[:,k], v1[:,k])
        if G < cutoff
            Ng = Ng + 1
        end
    end
    return Ng
end


function do_loop_no_inbounds( Ns::Int64, cutoff::Float64 )
    v1 = rand(3,Ns)
    Ng = 0
    for k = 1:Ns
        G = dot( v1[:,k], v1[:,k])
        if G < cutoff
            Ng = Ng + 1
        end
    end
    return Ng
end

function test_main()
    Ng = do_loop( 500_000, 5000.0 )
    Ng = do_loop_no_inbounds( 500_000, 5000.0 )
end

test_main()
