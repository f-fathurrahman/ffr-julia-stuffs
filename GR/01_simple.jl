import GR

function test_main()
    Npoints = 50
    x = Array(linspace(0.0, 1.0, 50))
    y = zeros(Npoints)
    for i = 1:Npoints
        y[i] = sin(x[i])
    end
    GR.plot(x, y)
    GR.savefig("TEMP_simpleplot.pdf")
end

test_main()
