function add_broadcast!(y, x)
    #CuArrays.@sync y .= y .+ x
    y .= y .+ x
    return nothing
end