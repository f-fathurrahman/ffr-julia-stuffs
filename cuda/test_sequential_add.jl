using Test

include("sequential_add.jl")

function main()
    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    sequential_add!(y, x)

    @test all(y .== 3.0)

    println("sequential_add passed.")
end

main()