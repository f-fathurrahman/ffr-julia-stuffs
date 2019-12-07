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

    #@btime sequential_add!($y, $x)
    #@btime cuarray_broadcast!($y_d, $x_d)

    sequential_add!(y, x)
    cuarray_broadcast!(y_d, x_d)

    @time sequential_add!(y, x)
    @time cuarray_broadcast!(y_d, x_d)

end

main()