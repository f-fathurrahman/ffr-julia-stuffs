using Test
using BenchmarkTools
using CuArrays

function test_01()
    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    y = y + x

    @test all( y .== 3.0 )

    println("test_01 is finished")
end

function sequential_add!(y, x)
    for i in eachindex(y, x)
        @inbounds y[i] = y[i] + x[i]
    end
    return nothing
end 

function test_02()
    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    sequential_add!(y, x)

    @test all(y .== 3.0)

    println("test_02 is finished")
end
#test_02()



function parallel_add!(y, x)
    Threads.@threads for i in eachindex(y, x)
        @inbounds y[i] = y[i] + x[i]
    end
    return nothing
end

function test_03(; testing=false)

    println("nthreads = ", Base.Threads.nthreads())

    N = 2^25
    x = fill(1.0, N)
    y = fill(2.0, N)

    sequential_add!(y, x)
    parallel_add!(y, x)

    @time begin
        for i in 1:100
            sequential_add!(y, x)
        end
    end

    @time begin
        for i in 1:100
            parallel_add!(y, x)
        end
    end

    #@btime sequential_add!($y, $x)
    #@btime parallel_add!($y, $x)

    if testing
        parallel_add!(y, x)
        @test all(y .== 3.0)
    end

    println("test_03 is finished")
end
#test_03()


function add_broadcast!(y, x)
    CuArrays.@sync y .= y .+ x
    return nothing
end

function test_04(; testing=false)

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.cufill(1.0, N)
    y_d = CuArrays.cufill(2.0, N)

    println(typeof(x_d))

    @btime sequential_add!($y, $x)

    @btime add_broadcast!($y_d, $x_d)

    println("test_04 is finished")
end
test_04()