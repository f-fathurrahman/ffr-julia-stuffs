function test1( NN::Array{Int64,1}, AA::Array{Float64,1} )
  @printf "typeof NN: %s\n" typeof(NN)
  @printf "typeof AA: %s\n" typeof(AA)
end

test1( [3,4,5], [5.0,3.0,1.0] )


