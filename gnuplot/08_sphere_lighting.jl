using Gnuplot

function main()
    Θ = LinRange(0, 2π, 100) # 50
    Φ = LinRange(0, π, 20)
    r = 0.8
    x = [r * cos(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
    y = [r * sin(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
    z = [r * cos(ϕ) for θ in Θ, ϕ in Φ]

    @gp "set term pdfcairo size 13cm,13cm fontscale 0.5" :-
    @gp :- "set output 'IMG_08_sphere_lighting.pdf'" :-
    
    #@gp "set term postscript size 13cm,13cm fontscale 0.5" :-
    #@gp :- "set output 'IMG_08_sphere_lighting.eps'" :-

    #@gp "set term png truecolor large enhanced size 1000,1000" :-
    #@gp :- "set output 'IMG_08_sphere_lighting.png'" :-

    #@gp "set term postscript size 13cm,13cm fontscale 0.5" :-
    #@gp :- "set output 'IMG_08_sphere_lighting.ps'" :-

    @gsp :- "set pm3d depthorder" :-
    @gsp :- "set style fill solid 1.0 noborder" :-
    @gsp :- "set view equal xyz" :-
    @gsp :- "set pm3d lighting primary 0.5 specular 0.6" :-
    @gsp :-  x y z "w pm3d notit" :-
    @gsp :- "set xyplane 0" :-
    @gsp :- "set xrange [-0.9:0.9]" :-
    @gsp :- "set yrange [-0.9:0.9]" :-
    @gsp :- palette(:viridis)

end
main()