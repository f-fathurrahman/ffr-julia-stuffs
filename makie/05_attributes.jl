using CairoMakie

x = range(0, 2*pi, length=100)
y1 = sin.(2*x)
y2 = 0.4*cos.(1.2*x)

scatter(x, y1, color=:red, markersize=5)
sc = scatter!(x, y2, color=:blue, markersize=10)

# Set the attributes later
sc.color = :green
sc.markersize = 20

save("IMG_05_attributes.pdf", current_figure())

