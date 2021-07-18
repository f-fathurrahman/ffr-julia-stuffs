using CairoMakie

x = range(0, 10, length=100)
y = sin.(x) + 2*cos.(0.5*x)

lines(x, y)
save("IMG_01_basic_line.pdf", current_figure())

