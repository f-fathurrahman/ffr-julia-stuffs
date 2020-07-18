W = rand(2, 5)
b = rand(2)

predict(x) = W*x .+ b
loss(x, y) = sum((predict(x) .- y).^2)

x, y = rand(5), rand(2)
println( loss(x, y) )

using Flux.Tracker

W = param(W)
b = param(b)

l = loss(x, y)
println("l = ", l)
back!(l)

