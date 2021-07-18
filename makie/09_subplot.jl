using CairoMakie

x = LinRange(0, 10, 100)
y = sin.(x)

fig = Figure()
lines(fig[1,1], x, y, color=:red)
lines(fig[1,2], x, y, color=:blue)
lines(fig[2,1:2], x, y, color=:green)

save("IMG_09_subplot.pdf", fig)

