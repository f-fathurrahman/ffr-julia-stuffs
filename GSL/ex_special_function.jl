using GSL
import PyPlot

const plt = PyPlot

function main()

  const n = 3
  const l = 0
  const m = 0

  r = linspace(0,10,500)
  N = size(r)[1]
  ψ = zeros(N)
  for i = 1:N
    ψ[i] = sf_laguerre_n( n-l-1, 2*l+1, r[i] ) * e^(-r[i]/2)*r[i]^l
    @printf("%d %f %f\n", i, r[i], ψ[i])
  end

  plt.clf()
  plt.grid(true)
  plt.plot( r, ψ, linewidth=2 )
  plt.savefig("Rnl_t1.png", dpi=300)
end

main()
