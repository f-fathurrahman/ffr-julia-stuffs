struct Point{T}
  x::T
  y::T
end

function test_main()

  p1 = Point{Float64}(1, 2)
  println(p1)

  p2 = Point{Int64}(1, 2)
  println(p2)

  println(Int64 <: Real)
  println(Float64 <: Real)

  p3 = Point{AbstractString}("a", "b")
  println(p3)

  val = Point{Float64} <: Point{Int64}
  println(val)

  val = point_norm_v1( p1 )
  println(val)

  val = point_norm_v1( p2 )
  println(val)

  val = point_norm_v2( p2 )
  println(val)

  val = point_norm_v3( p2 )
  println(val)

end

"""
# Incorrectly defined function
function point_norm(p::Point{Real})
  return sqrt(p.x^2 + p.y^2)
end
"""

# A correct way to define a method that accepts all arguments of type Point{T}
# where T is a subtype of Real
function point_norm_v1( p::Point{<:Real} )
  return sqrt(p.x^2 + p.y^2)
end

# Another way
function point_norm_v2{T<:Real}( p::Point{T} )
  return sqrt(p.x^2 + p.y^2)
end

# Yet another way
function point_norm_v3( p::Point{T} where T<:Real )
  return sqrt(p.x^2 + p.y^2)
end

@time test_main()
