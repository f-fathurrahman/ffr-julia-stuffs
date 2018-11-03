using DelimitedFiles
using Printf
using Plots


import Plots
Plots.gr()
Plots.default( size=(600,800) ) #Plot canvas size
Plots.default( markersize=3 )
Plots.default( grid=false )
Plots.default( framestyle=:box )

function test_plot_bands()
    ebands = readdlm("bands_Cu_fcc.dat", comments=true)
    Nbands = size(ebands)[2] - 1
    ene = ebands[:,1]
    Plots.plot( ene, ebands[:,2], leg=false, markershape=:circle )
    for ibands = 2:Nbands-1  # skip the last band
        Plots.plot!( ene, ebands[:,ibands+1], markershape=:circle, leg=false )
    end
    Plots.plot!( [3], seriestype=:vline, color=Plots.RGB( 1-220/225, 1-220/225, 1-220/225) )
    Plots.savefig( "TEMP_bands_Cu_fcc.pdf" )
end

test_plot_bands()

