using Plots

Plots.gr()

Plots.default( markersize=4 )
Plots.default( markershape=:circle )
Plots.default( framestyle=:box )


include("utils.jl")
include("discrete_fourier_coefficients.jl")
include("fourier_interpolant_from_modes.jl")

function func1(x::Float64)
    return x
end

function func2(x::Float64)
    return x*(2*pi - x)
end

function func3(x::Float64)
    return 3.0/(5.0 - 4*cos(x))
end

function test_main(N::Int64, my_func::Function)

    x = zeros(N)
    for i = 1:N
        x[i] = (i-1)/N*2*pi
    end
    # 2pi is excluded from the range

    f = my_func.(x)
    F = discrete_fourier_coefficients(f)

    Npts_plot = 100
    x_plot = range(0.0, stop=2*pi, length=Npts_plot)

    ff = zeros(ComplexF64,Npts_plot)
    for i = 1:Npts_plot
        ff[i] = fourier_interpolant_from_modes(F, x_plot[i])
    end

    Plots.plot(x, f)
    Plots.plot!(x_plot, real(ff))
    Plots.plot!(x_plot, imag(ff))
    Plots.savefig("TEMP_f_vs_ff_"*string(my_func)*".pdf")
end

@time test_main( 20, func1 )
@time test_main( 20, func2 )
@time test_main( 20, func3 )