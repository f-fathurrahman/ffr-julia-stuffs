using CairoMakie

x = range(0, 2*pi, length=100)
y1 = sin.(2*x)
y2 = 0.4*cos.(1.2*x)

scatter(x, y1, color=:red, markersize=range(5,15,length=100))
scatter!(x, y2, color=range(0,1,length=100), colormap=:thermal)
save("IMG_07_array_attr.pdf", current_figure())
