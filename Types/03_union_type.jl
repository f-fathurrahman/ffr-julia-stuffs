using CuArrays

"""
Data type that uses CPU array
"""
struct GVectors
    Ng::Int64
    G2::Array{Float64,1}
end

function GVectors(Ng::Int64)
    return GVectors(Ng, rand(Float64,Ng))
end


"""
Data type that uses GPU array
"""
struct CuGVectors
    Ng::Int64
    G2::CuArray{Float64,1}
end

# Simply copy from GVectors
function CuGVectors( Ng::Int64 )
    
    # First initialize Ng at CPU
    gvec = GVectors(Ng)
    
    # Then copy to GPU
    G2 = CuArray( gvec.G2 )

    return CuGVectors( Ng, G2 )
end


"""
Container data type, might use GVectors or CuGVectors.
"""
struct PWGrid
    gvec::Union{GVectors,CuGVectors}
end


function PWGrid( Ng::Int64; use_cuda=false )
    if use_cuda
        gvec = CuGVectors(Ng)
    else
        gvec = GVectors(Ng)
    end
    return PWGrid(gvec)
end


function main()
    pw_1 = PWGrid( 5 )
    pw_2 = PWGrid( 5, use_cuda=true )

    println(pw_1)

    println(pw_2)

    println(fieldnames(typeof(pw_1)))
    println(fieldnames(typeof(pw_2)))

    println("Pass here")
end

main()