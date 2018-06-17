using Printf
using Random

mutable struct WaveDesc
    Ns::Tuple{Int64,Int64,Int64}
    idxr2g::Array{Int64,1}
    dVol::Float64
end

mutable struct Wavefunction
    data::Array{Float64,1}
    wavedesc::Ref{WaveDesc}
end

function create_wavefunction()
    Ns = (3,3,3)
    Npoints = prod(Ns)
    idxr2g = rand(1:Npoints,Npoints)
    dVol = 0.1
    data = rand(Float64,Npoints)
    wavedesc = WaveDesc(Ns,idxr2g,dVol)
    wf = Wavefunction(data, Ref(wavedesc))
    return wf
end


function main()
    wf = create_wavefunction()
    println(wf)
    println(wf.wavedesc.x.dVol)
    wf.wavedesc.x.dVol = 0.01
end

main()

