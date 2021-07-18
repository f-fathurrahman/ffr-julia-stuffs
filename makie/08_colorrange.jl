using CairoMakie

x = range(0, 2*pi, length=100)
y = sin.(2*x)

colors = repeat([:crimson, :dodgerblue, :slateblue1, :sienna1, :orchid1], 20)

scatter(x, y1, color=colors, markersize=20)

# or using
# sc = scatter(x, y1, color=colors, markersize=20)
# sc.colorrange(0.25, 0.75)

save("IMG_08_colorrange.pdf", current_figure())
