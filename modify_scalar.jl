function modify_me!( a )
    a = 1.0
    println("In modify_me: a  = ", a)
    return
end

function main()
    a = 2.0
    
    println("Original: a = ", a)
    
    modify_me!( a )
    
    println("After modify_me: a = ", a)

end

function main2()
    a = 2.0
    
    println("Original: a = ", a)
    
    modify_me!( Ref{Float64}(a) )
    
    println("After modify_me: a = ", a)

end

main()
main2()