import PyPlot
using LaTeXStrings

const plt = PyPlot

xGrid = 0:0.1:5
G(x) = 0.5*x^2 - 2*x
g(x) = x - 2

ax = plt.subplot()

#ax.spines["left"].set_position["zero"]

plt.plot(xGrid, G.(xGrid), "b", label="G(x)")
plt.plot(xGrid, g.(xGrid), "r", label="g(x)")
plt.legend(loc="upper center")
plt.title(L"Plot of $G(x)$")

plt.savefig("TEMP_Listing_1_9.pdf")
