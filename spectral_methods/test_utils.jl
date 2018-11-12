using Printf
include("utils.jl")

function test_fold_unfold(N::Int64)
    
    println()
    println("Testing fold_half and unfold_half: N = ", N)
    println()

    for i = 1:N
        A = fold_half(i,N)
        B = unfold_half(A,N)
        @printf("%4d %4d %4d\n", i, A, B)
    end
end

test_fold_unfold(6)