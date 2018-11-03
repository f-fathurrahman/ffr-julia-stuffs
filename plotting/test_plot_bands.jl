using DelimitedFiles
using Printf
using Plots


import Plots
Plots.gr()
fntsm = Plots.font("serif", 12.0)
fntlg = Plots.font("serif", 16.0)
default( titlefont=fntlg, guidefont=fntlg, tickfont=fntsm, legendfont=fntsm )
Plots.default( size=(600,800) )
Plots.default( markersize=4 )
Plots.default( markershape=:circle )
Plots.default( grid=false )
Plots.default( framestyle=:box )
Plots.default( leg=false )

function test_plot_bands()

    filebands = "bands_Cu_fcc.dat"

    f = open(filebands, "r")
    l = readline(f)
    Nkpt_spec = parse( Int64, replace(l, "#" => "") )
    symb_kpts_spec = Array{String}(undef,Nkpt_spec)
    x_kpts_spec = zeros(Nkpt_spec)
    for ik = 1:Nkpt_spec
        l = readline(f)
        ll = split( strip(replace(l, "#" => "")) , " " )
        x_kpts_spec[ik] = parse( Float64, ll[1] )
        symb_kpts_spec[ik] = ll[2]
    end
    close(f)
    println(symb_kpts_spec)

    ebands = readdlm("bands_Cu_fcc.dat", comments=true)
    Nbands = size(ebands)[2] - 1
    ene = ebands[:,1]

    Plots.plot( ene, ebands[:,2], color=:black,
                xticks=(x_kpts_spec,symb_kpts_spec) )
    for ibands = 1:Nbands-1 # skip the last band
        Plots.plot!( ene, ebands[:,ibands+1] )
    end

    for ik = 1:Nkpt_spec
        Plots.plot!( [x_kpts_spec[ik]], seriestype=:vline, color=Plots.RGB(0.5,0.5,0.5) )
    end

    Plots.savefig( "TEMP_bands_Cu_fcc.pdf" )
end

test_plot_bands()

