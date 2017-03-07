using PyPlot

x = linspace(0, 2*pi, 1000)
y = cos(3.0*x.^2 + 4*cos(2*x))
plot(x, y, color="red", linewidth=2.0, linestyle="--")
title("A sinusoidally modulated sinusoid")
savefig("CosCos.png", dpi=300)

