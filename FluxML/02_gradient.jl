using Flux

f(x) = 3x^2 + 2x + 1 + log(x)
df(x) = gradient(f, x)[1]
d2f(x) = gradient(df, x)[1]

println( df(2.0) )
#println( d2f(2.0) )
println( df(2.3) )
