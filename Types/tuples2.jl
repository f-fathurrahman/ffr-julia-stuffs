"""
Tuples are an abstraction of the argument of a function - without the function
itself.
A tuple type is similar to a parametrized immutable type where each parameter
is the type of one field.
"""

struct Tuple2{A,B}
  a::A
  b::B
end


function test_main()

  println( Int <: Float64 )
  println( Int <: Number )
  println( Tuple{Int} <: Tuple{Number} )
  println( Tuple{Float64} <: Tuple{Real} )

  println( typeof((1,3.4,"Hello",:A) ))

end

@time test_main()
