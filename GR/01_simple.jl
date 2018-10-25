import GR

"""
A poor man's replacement for Julia's removed `linspace`
"""
function linspace(x1::Float64, x2::Float64, Npoints::Int64)
    dx = (x2 - x1)/(Npoints+1)
    v = zeros(Npoints)
    for i = 1:Npoints
        v[i] = x1 + (i-1)*dx
    end
    return v
end

#=
function test_plot()
    Npoints = 50
    x = linspace(0.0, 2*pi, 50)
    y1 = zeros(Npoints)
    y2 = zeros(Npoints)
    for i = 1:Npoints
        y1[i] = sin(x[i])
        y2[i] = cos(x[i])
    end
    GR.plot(x, y1, x, y2)
    GR.xlim([0,2*pi])
    GR.savefig("TEMP_simpleplot.pdf")
end
test_plot()
=#

#=
function test_polymarker()
    ENV["GKS_WSTYPE"] = "pdf"
    Npoints = 50
    x = linspace(0.0, 2*pi, 50)
    y1 = zeros(Npoints)
    y2 = zeros(Npoints)
    for i = 1:Npoints
        y1[i] = sin(x[i])
        y2[i] = cos(x[i])
    end
    GR.setviewport(0, 0.8, 0, 0.6)
    GR.setwindow(0, 2*pi, -1, 1)
    GR.setmarkertype(-1)
    GR.setmarkersize(2)
    GR.polymarker(x, y1)
    GR.updatews()
end
test_polymarker()
=#


#=
function test_polyline()
    ENV["GKS_WSTYPE"] = "pdf"
    Npoints = 50
    x = linspace(0.0, 2*pi, 50)
    y1 = zeros(Npoints)
    y2 = zeros(Npoints)
    for i = 1:Npoints
        y1[i] = sin(x[i])
        y2[i] = cos(x[i])
    end
    GR.setviewport(0, 0.8, 0, 0.6)
    GR.setwindow(0, 2*pi, -1, 1)
    GR.setlinetype(GR.LINETYPE_DOTTED)
    GR.setlinewidth(2)
    GR.polyline(x, y1)
    GR.setlinewidth(3)
    GR.polyline(x, y2)
    GR.updatews()
end
test_polyline()
=#


function test_polymarker_v2()
    ENV["GKS_WSTYPE"] = "pdf"
    Npoints = 50
    X = linspace(0.0, 2*pi, 50)

    GR.setviewport(0, 0.8, 0, 0.6)
    GR.setwindow(0, 2*pi, -1, 1)
    GR.setmarkertype(-1)
    GR.setmarkersize(2)
    
    for x in X
        y1 = sin(x)
        y2 = cos(x)
        GR.polymarker([x], [y1])
    end
end
test_polymarker_v2()
