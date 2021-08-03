#function my_func1!(A::Array{Float64,2})
#function my_func1!( A::Array{Float64} )
function my_func1!( A )
    Nrow = size(A,1)
    Ncol = size(A,2)
    for j in 1:Ncol
        for i in 1:Nrow
            A[i,j] = 1 + A[i,j]
        end
    end
    return
end

function main()
    A = rand(5,5)
    my_func1!(A)
    @views my_func1!(A[1:3,1:2])
    display(A); println()
end

main()

