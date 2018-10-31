import Plots

const plt = Plots

plt.gr()

function simple_lines()
    
    Npoints = 100
    
    x = range(0, stop=1.0, length=Npoints)
    y1 = zeros(Npoints)
    y2 = zeros(Npoints)
    
    for i = 1:Npoints
        y1[i] = sin(2*pi*x[i])
        y2[i] = cos(2*pi*x[i])
    end
    
    plt.plot(x, y1)
    plt.plot!(x, y2)
    plt.savefig("TEMP_simple_lines.pdf")
end

simple_lines()