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

function create_rand_wavefunction( wavedesc::WaveDesc )
    Npoints = prod(wavedesc.Ns)
    data = rand(Float64,Npoints)
    wf = Wavefunction(data, Ref(wavedesc))
    return wf
end


function main()
    
    Ns = (3,3,3)
    Npoints = prod(Ns)
    idxr2g = rand(1:Npoints,Npoints)
    dVol = 0.1
    wavedesc = WaveDesc(Ns,idxr2g,dVol)

    wf1 = create_rand_wavefunction( wavedesc )
    wf2 = create_rand_wavefunction( wavedesc )

    println("sizeof wf1 = ", Base.summarysize(wf1))
    println("sizeof wf2 = ", Base.summarysize(wf2))

    println("size of wavedesc = ", Base.summarysize(wavedesc))
    println("size of wf1.data = ", Base.summarysize(wf1.data))
    println("size of wf1.wavedesc = ", Base.summarysize(wf1.wavedesc))

    println(27*8)

    # try to modify field of wavedesc
    println("Orig dVol = ", wf1.wavedesc.x.dVol)
    # modify via wf1
    wf1.wavedesc.x.dVol = 1.0
    println()

    println("wf1 dVol = ", wf1.wavedesc.x.dVol)
    println("wf2 dVol = ", wf2.wavedesc.x.dVol)
end

main()

