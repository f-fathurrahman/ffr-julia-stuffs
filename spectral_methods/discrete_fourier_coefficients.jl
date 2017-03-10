#
# Algorithm 1 (page 17)
#
function discrete_fourier_coefficients( f )

  N = size(f)[1]
  F = zeros( Complex128, N )

  #for k = -N/2 : N/2
  for kk = 1:N
    k = nn_to_mm(kk,N)
    s = 0.0 + im*0.0
    for j = 0:N-1
      s = s + f[j+1]*exp(-2*pi*im*j*k/N)
    end
    F[kk] = s/N
  end
  return F
end

# map k = [-N/2:N/2] to 1:N
# FIXME: Need to to think of another name for this function
function nn_to_mm( nn::Int, S::Int )
  return nn - Int(floor(S/2)) - 1
end
