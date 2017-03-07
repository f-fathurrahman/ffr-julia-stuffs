# Based on: http://samuelcolvin.github.io/JuliaByExample/ 
# 
# "execute" the script using command include("src.jl")

#
# The mandatory HelloWorld
#
println("Hello World")


#
# Simple functions
#

function sphere_vol( r )
  # not using 4.0 ?
  return 4/3*pi*r^3
end

# another way to define a function
quadratic( a, sqr_term, b ) = (-b + sqr_term) / 2a
# not using 2*a ?

# Calculates x for 0 = a*x^2 + b*x + x
# argument types can be defined in function definition
function quadratic2( a::Float64, b::Float64, c::Float64 )
  # unlike other language, 2a is equivalent to 2*a
  sqr_term = sqrt( b^2 - 4a*c )
  r1 = quadratic( a, sqr_term, b )
  r2 = quadratic( a, -sqr_term, b )
  # multiple values can be returned from a function using tuples
  # if the return keyword is omitted, the last term is returned
  r1, r2
end


vol = sphere_vol(3)
# @printf allows number formatting but does not automatically append the \n statements
@printf "Volume = %0.3f\n" vol

quad1, quad2 = quadratic2( 2.0, -2.0, -12.0 )
println( "Root 1: ", quad1 )
println( "Root 2: ", quad2 )

#
# String examples
#

# Strings are defined with double quotes.
# Like variables, string can contain any unicode character
s1 = "The quick brown fox jumps over the lazy dog"
println( s1 )
