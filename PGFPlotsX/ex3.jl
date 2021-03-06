using PGFPlotsX
using LaTeXStrings

fig = @pgf Axis(
    {
        xlabel = L"x",
        ylabel = L"f(x) = x^2 - x + 4",
    },
    PlotInc({samples=10},
        Expression("x^2 - x + 4")
    )
)

pgfsave("TEMP_ex3.pdf", fig)


