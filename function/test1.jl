function modify( a::Array{Float64,2}, b::Array{Float64,2} )
    @assert( size(a) == size(b) )

    a[1,1] = 3.3
end

function test_main()
    v1 = zeros(4,3)
    v2 = zeros(4,3)
    
    v1 .= 1.0
    v2 .= 2.0
    
    println("")   
    println(v1)
    println(v2)
    
    modify(v1[:,:],v2[:,:])  # this will pass by value !
 
    println("")   
    println(v1)
    println(v2)

    modify(v1,v2)

    println("")   
    println(v1)
    println(v2)

end

test_main()

