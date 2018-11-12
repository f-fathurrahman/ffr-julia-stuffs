# map k = [-N/2:N/2] to 1:N
#=
1 -> -3
2 -> -2
3 -> -1
4 ->  1
5 ->  2
6 ->  3
=#
#=
function fold_half( nn::Int64, N::Int64 )
    if nn <= N/2
        return nn - Int64(N/2) - 1  # negative
    else
        return nn - Int64(N/2)      # positive
    end
end


function unfold_half( nn::Int64, N::Int64 )
    if nn < 0
        return nn + Int64(N/2) + 1
    else
        return nn + Int64(N/2)
    end
end
=#

function fold_half( nn::Int64, N::Int64 )
    return nn - Int64(N/2) - 1
end


function unfold_half( nn::Int64, N::Int64 )
    return nn + Int64(N/2) + 1
end