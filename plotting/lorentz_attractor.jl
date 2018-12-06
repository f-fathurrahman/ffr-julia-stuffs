import Plots
const plt = Plots
plt.gr()

function test_01()

    n = 1500
    dt = 0.02
    σ, ρ, β = 10., 28., 8/3
    x, y, z = 1., 1., 1.
    
    # initialize 3D plot with 1 empty series
    my_path3d = plt.path3d(1, xlim=(-25,25), ylim=(-25,25), zlim=(0,50),
                           xlab = "x", ylab = "y", zlab = "z",
                           title = "Lorentz Attractor", marker = 1)
    plt.savefig("TEMP_lorentz_attractor.pdf")
end
test_01()
