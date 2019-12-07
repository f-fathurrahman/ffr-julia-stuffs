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
    CuArrays.@sync begin
        @cuda threads=256 blocks=numblocks cuda_add_v3!( y, x )
    end
end