using Plots
gr()

#plot( Plots.fakedata(50,5), w=3 )
#savefig( "ex1.pdf" )

p = plot( [sin,cos], zeros(0), leg=false )
anim = Animation()
for x = linspace(0,10π,100)
  push!( p, x, Float64[sin(x), cos(x)] )
  frame(anim)
end

# save the animation
gif( anim, "anim1.gif", fps=10 )
