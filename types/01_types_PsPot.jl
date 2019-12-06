abstract type AbstractPsPot
end

struct PsPot_GTH <: AbstractPsPot
    Nr::Int64
    r::Array{Float64,1}
end

struct PsPot_UPF <: AbstractPsPot
    Nr::Int64
    r::Array{Float64,1}
    Vloc::Array{Float64,1}
end

function myfunc1( psp::AbstractPsPot )
    println("This myfunc1: function is called:")
    psp |> typeof |> println
end


function main()
    Nr = 10
    psp1 = PsPot_UPF(Nr, rand(Nr), rand(Nr))
    psp2 = PsPot_GTH(Nr, rand(Nr))
    myfunc1(psp1)
    myfunc1(psp2)
end

main()