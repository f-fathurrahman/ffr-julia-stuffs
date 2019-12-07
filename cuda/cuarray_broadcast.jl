function cuarray_broadcast!(y, x)
    CuArrays.@sync y .= y .+ x
    y .= y .+ x
    return nothing
end

function cuarray_broadcast_nosync!(y, x)
    y .= y .+ x
    return nothing
end