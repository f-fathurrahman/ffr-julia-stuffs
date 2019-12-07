function cuda_add_v2!(y, x)
    index = threadIdx().x    # this example only requires linear indexing, so just use `x`
    strd = blockDim().x
    for i in index:strd:length(y)
        @inbounds y[i] += x[i]
    end
    return
end

function bench_cuda_add_v2!(y, x)
    CuArrays.@sync begin
        @cuda threads=256 cuda_add_v2!(y, x)
    end
    return
end