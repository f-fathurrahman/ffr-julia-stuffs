include("discrete_fourier_coefficients.jl")

function test_nn_mm()
  N = 4
  a = range(1,N)
  for i in a
    A = nn_to_mm(i,N)
    println(A)
  end
end

function test_main()

  N = 5

  #f = ones(N)
  srand(1234)
  f = rand(N)

  F = discrete_fourier_coefficients(f)

  F_fft = fft(f)/N  # need normalization to match the convention used here

  for i = 1:N
    @printf("%4d %18.10f (%18.10f,%18.10f) (%18.10f,%18.10f)\n",
            i, f[i], real(F[i]), imag(F[i]), real(F_fft[i]), imag(F_fft[i]) )
  end
end

test_main()
