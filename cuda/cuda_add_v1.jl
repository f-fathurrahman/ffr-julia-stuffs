function cuda_add_v1!(y, x)
    for i in 1:length(y)
        @inbounds y[i] = y[i] + x[i]
    end
    return
end

function bench_cuda_add_v1!(y, x)
    CuArrays.@sync begin
        @cuda cuda_add_v1!(y, x)
    end
end