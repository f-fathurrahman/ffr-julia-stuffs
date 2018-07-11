function test(a)
    if mod(a,2) != 2
        throw( ErrorException("a must be divisible by 2") )
    end
    println("SUCCESS")
end

function main()
    test(3)
    test(2)
end

main()


