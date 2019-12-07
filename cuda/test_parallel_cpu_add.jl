using Test

include("parallel_cpu_add.jl")

function main()

    println("nthreads = ", Base.Threads.nthreads())

    N = 2^25
    x = fill(1.0, N)
    y = fill(2.0, N)

    parallel_cpu_add!(y, x)
    @test all(y .== 3.0)

    println("parallel_cpu_add passed.")

end

main()