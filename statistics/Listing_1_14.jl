using Random, LinearAlgebra, PyPlot, PyCall
using Printf

const plt = PyPlot

#@pyimport matplotlib.patches as patch
patch = pyimport("matplotlib.patches")

Random.seed!(1234)

N = 10^5

data = [ [rand(), rand()] for _ in 1:N]

indata = filter( (x) -> (norm(x) <= 1), data)
outdata = filter( (x) -> (norm(x) > 1), data)

piApprox = 4*length(indata)/N
@printf("Estimate of pi = %18.10f\n", piApprox)
@printf("Abs diff = %15.10e\n", abs(pi-piApprox))

fig = plt.figure("Primitives", figsize=(5,5))

plt.plot(first.(indata), last.(indata), "b.", ms=0.2)
plt.plot(first.(outdata), last.(outdata), "r.", ms=0.2)

plt.savefig("TEMP_Listing_1_14.pdf")

