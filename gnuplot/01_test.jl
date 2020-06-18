using Gnuplot

x = 1:10

@gp "set term pdfcairo" :-
@gp :- "set output 'IMG_01.pdf'" :-
@gp :- x "w l t 'boring line' lc 'black'"
