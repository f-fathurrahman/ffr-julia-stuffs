function sequential_add!(y, x)
    for i in eachindex(y, x)
        @inbounds y[i] = y[i] + x[i]
    end
    return nothing
end 