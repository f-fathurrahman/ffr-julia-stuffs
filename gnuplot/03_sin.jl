using Gnuplot

t = 0:0.001:1

@gp "set term pdfcairo" :-
@gp :- "set output 'IMG_03.pdf'" :-
@gp :- t  sin.(10*pi*t) "w l t 'my sine' lc 'black'"
