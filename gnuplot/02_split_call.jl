using Gnuplot

@gp "set term pdfcairo" :-
@gp :- "set output 'IMG_sin.pdf'"  :-
@gp :- "plot sin(x)" :-
@gp :- "plot cos(x)"
