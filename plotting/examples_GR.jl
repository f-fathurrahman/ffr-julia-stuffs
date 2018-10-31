import Plots

const plt = Plots
plt.gr()

function simple_lines()
    plt.plot( Plots.fakedata(50,6), w=3 )
    plt.savefig( "TEMP_lines_fakedata.pdf" )
end
simple_lines()