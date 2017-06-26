abstract type Pointy{T} end

struct Point{T} <: Pointy{T}
  x::T
  y::T
end

struct DiagPoint{T} <: Pointy{T}
  x::T
end

function test_main()

  println( Pointy{Int64} <: Pointy )

  println( Pointy{1} <: Pointy )

  println( Pointy{Float64} <: Pointy{Real} )
  println( Pointy{Float64} <: Pointy{<:Real} )

  print( Pointy{Real} <: Pointy{>:Int} )

end


@time test_main()
