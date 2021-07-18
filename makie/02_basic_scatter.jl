using CairoMakie

x = range(0, 10, length=100)
y = sin.(x) + 2*cos.(2*x)

scatter(x, y)
save("IMG_02_basic_scatter.pdf", current_figure())

