using CUDA
using BenchmarkTools

include("sequential_add.jl")

function cuda_add_v2!(y, x)
    index = threadIdx().x    # this example only requires linear indexing, so just use `x`
    strd = blockDim().x
    for i in index:strd:length(y)
        @inbounds y[i] = y[i] + x[i]
    end
    return
end

function bench_cuda_add_v2!(y, x)
    CUDA.@sync begin
        @cuda threads=256 cuda_add_v2!(y, x)
    end
end

function main()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CUDA.fill(1.0, N)
    y_d = CUDA.fill(2.0, N)

    @btime sequential_add!($y, $x)

    @btime bench_cuda_add_v2!($y_d, $x_d) # use the sync-ed version

end

main()