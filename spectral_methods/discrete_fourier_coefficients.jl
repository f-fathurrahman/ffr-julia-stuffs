#
# Algorithm 1 (page 17)
#
function discrete_fourier_coefficients( f )

    N = size(f)[1]
    F = zeros(ComplexF64, N)

    for kk = 1:N
        k = fold_half(kk,N)
        s = 0.0 + im*0.0
        for j = 0:N-1
            s = s + f[j+1]*exp(-2*pi*im*j*k/N)
        end
        F[kk] = s/N
    end
    return F
end
