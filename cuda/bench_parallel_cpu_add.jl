include("sequential_add.jl")
include("parallel_cpu_add.jl")

function main(; testing=false)

    println("nthreads = ", Base.Threads.nthreads())

    N = 2^25

    x = fill(1.0, N)
    y = fill(2.0, N)
    sequential_add!(y, x)    
    @time sequential_add!(y, x)
    
    x = fill(1.0, N)
    y = fill(2.0, N)
    parallel_cpu_add!(y, x)
    @time parallel_cpu_add!(y, x)

end

main()