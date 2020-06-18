using Gnuplot
x = -2*pi:0.001:2*pi

println(length(x))

@gp("set term pdfcairo", :-)
@gp(:-, "set output 'IMG_04_sin_cos.pdf'", :-)

@gp(:-, "set grid", :-)
@gp(:-, "set yrange [-1.1:1.1]", :-)

@gp(:-, x, sin.(x), "with lines title 'my sin'", :-)

@gp(:-, x, cos.(x), "with linespoints ls 1 title 'my cos'", :-)
@gp(:-, "set style line 1 lc rgb 'black' lt 1 lw 1 pt 6 pi -300 pointsize 0.75", :-)

@gp(:-, x, sin.(x).*cos.(x), "with linespoints ls 2 title 'my sin cos'", :-)
@gp(:-, "set style line 2 lc rgb 'blue' lt 1 lw 1.5 pt 6 pi -300 pointsize 1.0")

