# https://makie.juliaplots.org/v0.15.2/examples/plotting_functions/arrows/

using GLMakie

pts = [
    Point3f(1.0, 0.0, 0.0),
    Point3f(0.0, 1.0, 0.0),
    Point3f(0.0, 0.0, 1.0),
]

dirs = [
    Vec3f(1.0, 0.0, 0.0),
    Vec3f(0.0, 1.0, 0.0),
    Vec3f(0.0, 0.0, 1.0)
]

arrows(
    pts, dirs,
    fxaa=true,
    linecolor = :blue,
    arrowcolor = :black,
    linewidth = 0.1,
    align = :center,
    axis = (type=Axis3,)
)


