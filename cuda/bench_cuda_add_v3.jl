using CUDA
using BenchmarkTools

include("sequential_add.jl")

function cuda_add_v3!( y, x )
    index = (blockIdx().x - 1) * blockDim().x + threadIdx().x
    strd = blockDim().x * gridDim().x
    for i in index:strd:length(y)
        @inbounds y[i] = y[i] + x[i]
    end
    return nothing
end

function bench_cuda_add_v3!(y, x)
    numblocks = ceil(Int64, length(y)/256)
    CUDA.@sync begin
        @cuda threads=256 blocks=numblocks cuda_add_v3!( y, x )
    end
end

function main()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CUDA.fill(1.0, N)
    y_d = CUDA.fill(2.0, N)

    @btime sequential_add!($y, $x)
    @btime bench_cuda_add_v3!($y_d, $x_d) # use the sync-ed version

    sequential_add!(y, x)
    bench_cuda_add_v3!(y_d, x_d)

    @time sequential_add!(y, x)
    @time bench_cuda_add_v3!(y_d, x_d)

end

main()