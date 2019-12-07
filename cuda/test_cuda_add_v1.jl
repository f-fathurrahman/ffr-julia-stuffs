using CuArrays
using CUDAnative

using Test

include("cuda_add_v1.jl")

function main()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.fill(1.0, N)
    y_d = CuArrays.fill(2.0, N)

    @cuda cuda_add_v1!(y_d, x_d)
    @test all( Array(y_d) .== 3.0 )

    println("cuda_add_v1 passed")
end

main()