module Mod1

function f1( x::Float64 )
  return x + 1.0
end

function f2( x::Float64 )
  return x + 2.0
end

function f3( x::Float64 )
  return x + 3.0
end

include("SubMod1.jl")


end
