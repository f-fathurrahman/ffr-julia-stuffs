using CuArrays
using CUDAnative
using BenchmarkTools

include("sequential_add.jl")
include("cuda_add_v1.jl")

function main()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.fill(1.0, N)
    y_d = CuArrays.fill(2.0, N)

    @btime sequential_add!($y, $x)

    @btime bench_cuda_add_v1!($y_d, $x_d) # use the sync-ed version

end

main()