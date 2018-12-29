using LinearAlgebra
using BenchmarkTools


function do_v1()
    println("Using mul!")
    A = rand(50,500)
    B = rand(500,5)
    Y = zeros(50,5)
    @btime mul!($Y, $A, $B)
end

function do_v2()
    println("Using * directly")
    A = rand(50,500)
    B = rand(500,5)
    @btime $A*$B
end

do_v1()
do_v2()


