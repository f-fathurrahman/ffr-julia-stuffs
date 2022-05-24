# https://makie.juliaplots.org/v0.15.2/examples/plotting_functions/arrows/

using GLMakie

ps = [Point3f(x, y, z) for x in -5:2:5 for y in -5:2:5 for z in -5:2:5]
ns = map(p -> 0.1 * Vec3f(p[2], p[3], p[1]), ps)
arrows(
    ps, ns, fxaa=true, # turn on anti-aliasing
    linecolor = :gray, arrowcolor = :black,
    linewidth = 0.1, arrowsize = Vec3f(0.3, 0.3, 0.4),
    align = :center, axis=(type=Axis3,)
)

