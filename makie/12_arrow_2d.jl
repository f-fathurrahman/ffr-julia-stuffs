# https://makie.juliaplots.org/v0.15.2/examples/plotting_functions/arrows/

using GLMakie

pts = [
    Point2f(2.0, 1.0),
    Point2f(3.0, 1.0),
    Point2f(0.0, 2.0)
]

dirs = [
    Vec2f(2.0, 1.0)/2,
    Vec2f(3.0, 1.0),
    Vec2f(0.0-3.0, 2.0-1.0)
]

arrows(
    pts, dirs,
    fxaa=true,
    linecolor=:red,
    arrowcolor=:black,
    arrowsize=30,
    linewidth=2.0,
    align=:origin,
    axis=(type=Axis,)
)


