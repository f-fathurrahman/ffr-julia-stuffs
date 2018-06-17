function call_simple()
    N = 5
    data = zeros(N)
    data[3] = 3.3
    Ns = [1, 3, 4]

    Ns_ = Base.cconvert( Array{Int32,1}, Ns )

    retval = ccall( (:simple,"./simple.so"), Int32,
                    (Int32, Ptr{Int32}, Ptr{Float64}), N, Ns_, data )

    println("Ns_ = ", Ns_)
    println("data = ", data)
    
    println("\nretval = ", retval)
end

call_simple()
