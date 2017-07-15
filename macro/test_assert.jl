macro my_assert(expr)
    return :( $expr ? nothing : throw(AssertionError($(string(expr)))) )
end

function test_main()
    @my_assert 1 < 1.1
    println( macroexpand( :(@my_assert 1 < 1.1) ) )

    a = 1.2
    b = 1.3
    println( macroexpand( :(@my_assert a < b) ) )
    # The following will not work
    #@my_assert a < b

    # Using standard Julia @assert
    println( macroexpand( :(@assert a < b) ) )
    @assert a < b

    println("test_main ended normally.")
end

test_main()
