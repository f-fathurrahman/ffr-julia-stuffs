import Plots

const plt = Plots
plt.gr()

function test_01()
    p = plt.plot( [sin,cos], zeros(0), leg=false )
    anim = plt.Animation()
    for x = range(0,stop=10π,length=100)
        push!( p, x, Float64[sin(x), cos(x)] )
        plt.frame(anim)
    end
    # save the animation
    plt.gif( anim, "TEMP_anim1.gif", fps=10 )
end
#test_01()

function my_func1(x::Vector{Float64}, t::Float64)
    return sin(2π*t).*x
end

function test_02()
    x = collect(range(0,stop=2π,length=100))
    anim = plt.Animation()
    Aa = cos.(x)
    for t in range(0,stop=0.5,length=10)
        plt.plot(x, my_func1(Aa,t))
        plt.ylims!(-1.0,1.0)
        plt.frame(anim)
    end
    plt.gif(anim, "TEMP_anim2.gif")
end
test_02()
