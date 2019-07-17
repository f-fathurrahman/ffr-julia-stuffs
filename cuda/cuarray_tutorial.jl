using Test
using BenchmarkTools
using CuArrays
using CUDAnative


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
#test_04()

function gpu_add1!(y, x)
    for i = 1:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end


function test_05()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.cufill(1.0, N)
    y_d = CuArrays.cufill(2.0, N)

    @cuda gpu_add1!(y_d, x_d)
    @test all( Array(y_d) .== 3.0 )

    println("test_05 is finished")
end
#test_05()

function gpu_add2!(y, x)
    index = threadIdx().x    # this example only requires linear indexing, so just use `x`
    strd = blockDim().x
    for i = index:strd:length(y)
        @inbounds y[i] += x[i]
    end
    return nothing
end

function bench_gpu2!(y, x)
    CuArrays.@sync begin
        @cuda threads=256 gpu_add2!(y, x)
    end
end


function test_06()

    N = 2^20
    x = fill(1.0, N)
    y = fill(2.0, N)

    x_d = CuArrays.cufill(1.0, N)
    y_d = CuArrays.cufill(2.0, N)

    @btime bench_gpu2!($y_d, $x_d)

    println("test_06 is finished")
end
test_06()
