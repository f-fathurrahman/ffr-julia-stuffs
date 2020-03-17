struct GVectors{T}
    Ng::Int64
    G::Array{T,2}
end

function random_GVectors()
    return GVectors{Float64}(10, rand(Float64,10))
end

function main()
    println("Pass here")
end

main()