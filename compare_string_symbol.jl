using BenchmarkTools
using Printf

function using_str( a::Float64; arg1 = "some_str" )
    if arg1 == "some_str"
        a = 0.2
    elseif arg1 == "str2"
        a = 0.3
    end
    return 2*a
end

function using_symbol( a::Float64; arg1 = :some_symbol )
    if arg1 == :some_symbol
        a = 0.2
    elseif arg1 == :symbol2
        a = 0.3
    end
    return 2*a
end

function main()
    a = 0.5

    @printf("Using str: ")
    @btime using_str( $a, arg1="str2" )
    
    @printf("Using symbol: ")
    @btime using_symbol( $a, arg1=:symbol2 )

    @printf("Using str: ")
    @btime using_str( $a )
    
    @printf("Using symbol: ")
    @btime using_symbol( $a )
    
    @printf("Using str: ")
    @btime using_str( $a, arg1="some_str" )
    
    @printf("Using symbol: ")
    @btime using_symbol( $a, arg1=:some_symbol )

end

main()
