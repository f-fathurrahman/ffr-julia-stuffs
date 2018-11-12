using Printf
using Random
using FFTW

include("utils.jl")
include("discrete_fourier_coefficients.jl")

function test_main(N::Int64)

    println()
    println("Testing discrete_fourier_coefficients: N = ", N)
    println()

    Random.seed!(1234)
    f = rand(N)

    F = discrete_fourier_coefficients(f)

    F_fft = fft(f)/N  # need normalization to match the convention used here

    # comparing the result between fft and discrete_fourier_coefficients

    for i = 1:N
        k = fold_half(i,N)
        @printf("i = %4d, k=%4d F[k] = (%18.10f,%18.10f)\n",
                 i, k, real(F[i]), imag(F[i]))
    end

    println()

    for i = 1:N
        @printf("i = %4d fft(f)[k] = (%18.10f,%18.10f)\n",
                 i, real(F_fft[i]), imag(F_fft[i]))
    end
end

test_main(6)
