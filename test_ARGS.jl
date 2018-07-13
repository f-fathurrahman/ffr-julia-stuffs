function main()
    Nargs = length(ARGS)
    @assert( Nargs >= 1 )

    command = Meta.parse( ARGS[1] )

    eval(command)
    
    println("\n-----------")
    println("End of main")
    println("-----------")
end

function myfun1()
    println("This is called from myfun1")
end

function myfun2()
    println("This is called from myfun2")
end

main()
