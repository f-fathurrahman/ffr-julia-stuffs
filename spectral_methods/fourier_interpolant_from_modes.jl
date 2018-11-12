#
# Algorithm 2
#
function fourier_interpolant_from_modes(fk::Array{ComplexF64,1}, x::Float64)
    N = size(fk)[1]
    s = 0.0 + im*0.0
    for i = 1:N
        k = fold_half(i, N)
        s = s + fk[i]*exp(im*k*x)
    end
    return s
end


#=
function fourier_interpolant_from_modes(fk::Array{ComplexF64,1}, x::Float64)
    N = size(fk)[1]
    # N must be even
    idx_first = Int64(-N/2)
    idx_last  = Int64(N/2)
    s = 0.5*( fk[1]*exp(-im*N*x/2) + fk[N]*exp(im*N*x/2) )
    for k = idx_first+1:idx_last-1
        i = unfold_half(k,N)
        s = s + fk[i]*exp(im*k*x)
    end
    return s
end
=#