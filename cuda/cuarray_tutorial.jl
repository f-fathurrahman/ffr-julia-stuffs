using Test
using BenchmarkTools
using CuArrays
using CUDAnative

function test_06()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.cufill(1.0, N)
    y_d = CuArrays.cufill(2.0, N)

    @btime bench_gpu2!($y_d, $x_d)

    println("test_06 is finished")
end
test_06()
