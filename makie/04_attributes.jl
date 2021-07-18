using CairoMakie

x = range(0, 2*pi, length=100)
y1 = sin.(2*x)
y2 = 0.4*cos.(1.2*x)

scatter(x, y1, color=:red, markersize=5)
scatter!(x, y2, color=:blue, markersize=10)
save("IMG_04_attributes.pdf", current_figure())
