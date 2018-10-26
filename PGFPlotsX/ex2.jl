using PGFPlotsX

fig = @pgf Axis(
    {
        xlabel = "Cost",
        ylabel = "Error",
    },
    Plot(
        {
            color = "red",
            mark  = "x"
        },
        Coordinates(
            [
                (2, -2.8559703),
                (3, -3.5301677),
                (4, -4.3050655),
                (5, -5.1413136),
                (6, -6.0322865),
                (7, -6.9675052),
                (8, -7.9377747),
            ]
        ),
    ),
)

pgfsave("TEMP_ex2.tex", fig)
