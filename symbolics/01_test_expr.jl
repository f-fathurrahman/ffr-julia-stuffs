using SymbolicUtils

@syms w z α::Real β::Real

println(w, z, α, β)

@show w isa Number
@show α isa Real

expr1 = α*sin(w)^2 + β*cos(z)^2
expr2 = α*cos(z)^2 + β*sin(w)^2

@show expr1 + expr2
