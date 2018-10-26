using PGFPlotsX

fig = 
@pgf TikzPicture(
        Axis(
            PlotInc({ only_marks },
                Table(; x = 1:2, y = 3:4)),
            PlotInc(
                Table(; x = 5:6, y = 1:2))))

pgfsave("TEMP_ex1.pdf", fig)


