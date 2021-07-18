using CairoMakie

x = range(0, 2*pi, length=100)
y1 = sin.(2*x)
y2 = 0.4*cos.(1.2*x)

lines(x, y1)
lines!(x, y2)
save("IMG_03_multiline.pdf", current_figure())
