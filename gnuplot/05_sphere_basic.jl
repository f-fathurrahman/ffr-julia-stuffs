using Gnuplot

function main()
    Θ = LinRange(0, 2π, 100) # 50
    Φ = LinRange(0, π, 20)
    r = 0.8
    x = [r * cos(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
    y = [r * sin(θ) * sin(ϕ)      for θ in Θ, ϕ in Φ]
    z = [r * cos(ϕ) for θ in Θ, ϕ in Φ]

    @gp "set term pdfcairo size 13cm,13cm fontscale 0.5" :-
    @gp :- "set output 'IMG_05_sphere_basic.pdf'" :-
    @gsp :- "set pm3d depthorder" :-
    @gsp :- x y z "w l notitle" :-
    @gsp :- "set view equal xyz"
end
main()