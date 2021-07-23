using SymbolicUtils

@syms w z α::Real β::Real

r1 = @rule sin(2*(~x)) => 2*sin(~x)*cos(~x)

@show r1(sin(2z))

@show r1(sin(2*(2*α))) # will return nothing?

# (~x) is called slot variable. It is a placeholder that match exactly
# one expression.

# Slot variable is not necessarily a single variable
@show r1(sin(2*(w-z))) # not working?

@show r1(sin(2w^2))
