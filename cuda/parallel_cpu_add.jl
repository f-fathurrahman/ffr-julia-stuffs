function parallel_cpu_add!(y, x)
    Threads.@threads for i in eachindex(y, x)
        @inbounds y[i] = y[i] + x[i]
    end
    return nothing
end