using Printf
using Random
using FFTW

include("discrete_fourier_coefficients.jl")

function test_nn_mm(N::Int64)
    for i = 1:N
        A = nn_to_mm(i,N)
        println(A)
    end
end

function test_main()

    N = 5
    test_nn_mm(N)

    #f = ones(N)
    Random.seed!(1234)
    f = rand(N)

    F = discrete_fourier_coefficients(f)

    F_fft = fft(f)/N  # need normalization to match the convention used here

    # comparing the result between fft and discrete_fourier_coefficients
    for i = 1:N
        @printf("%4d %18.10f (%18.10f,%18.10f) (%18.10f,%18.10f)\n",
                i, f[i], real(F[i]), imag(F[i]), real(F_fft[i]), imag(F_fft[i]) )
    end
end

test_main()
