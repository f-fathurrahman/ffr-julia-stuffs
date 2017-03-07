using PyPlot

x = linspace(-2*pi, 2*pi, 1000)
y1  = 0.2*x.^3 - 0.3*x.^2 + 1.2*x + 1
y2 = 0.2*x.^4 - 0.4*x.^3 + 1.2*x + 1
plot(x, y1, linewidth=2.0, linestyle="--")
plot(x, y2, linewidth=2.0, linestyle="--")
title("Polynomial")
xlabel("X title")
ylabel("Y title")
grid()
savefig("poly1.png", dpi=300)
savefig("poly1.pdf")


