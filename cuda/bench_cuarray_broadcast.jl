using CuArrays
using BenchmarkTools

include("sequential_add.jl")
include("cuarray_broadcast.jl")

function main()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.fill(1.0, N)
    y_d = CuArrays.fill(2.0, N)

    println(typeof(x_d))

    @btime sequential_add!($y, $x)

    @btime add_broadcast!($y_d, $x_d)

end

main()