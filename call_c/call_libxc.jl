function test_main()

  ρ = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6]
  σ = [0.2, 0.3, 0.4, 0.5, 0.6, 0.7]
  N = size(ρ)[1]

  x_gga = zeros(N)
  c_gga = zeros(N)

  XC_GGA_X_PBE = 101
  XC_GGA_C_PBE = 130

  ccall( (:ffrlibxc, "ffrlibxc"), Void,
         (Int, Int, Ptr{Float64}, Ptr{Float64}, Ptr{Float64}),
         XC_GGA_X_PBE, N, ρ, σ, x_gga )



  println(ρ)
  println(exc)

end

test_main()
