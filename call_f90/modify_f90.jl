N = 10
a = 3.0*ones(N)
b = 4.0*ones(N)
c = zeros(N)

println("a = ", a)
println("b = ", b)
println("c = ", c)

ccall( (:__mymodule_MOD_calc_something01, "module1.so"),
    Cvoid, (Ref{Int32}, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
    N, a, b, c
)


ccall( (:__mymodule_MOD_calc_something03, "module1.so"),
    Cvoid, (Ref{Int64},),
    N
)

println("a = ", a)
println("b = ", b)
println("c = ", c)

