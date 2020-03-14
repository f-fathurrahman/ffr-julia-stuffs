function euclidean_algorithm_division_count(a::BigInt, b::BigInt)
    division_count = 1
    if b > a
        a, b = b, a
    end
    while (c = a % b) != 0
        a, b = b, c
        division_count += 1
    end
    return division_count
end

function main()
    N = big(10)^100
    M = 10^4
    division_count_array = []
    while M > 0
        a, b = rand(1:N, 2)
        push!(division_count_array, euclidean_algorithm_division_count(a, b))
        M -= 1
    end
end

function main3()
    N = big(10)^100
    division_count_array = Array{Int}(undef, 10^4)
    for i ∈ 1:length(division_count_array)
        division_count_array[i] = euclidean_algorithm_division_count(rand(1:N), rand(1:N))
    end
end

function main4()
    N = big(10)^100
    R = 1:N
    M = 10^4
    division_count_array = zeros(typeof(N),M) #Vector{Int64}(undef, M)
    while M > 0
        a, b = rand(R, 2)
        division_count_array[M] = euclidean_algorithm_division_count(a, b)
        M -= 1
    end
end

@time main4()
@time main4()

