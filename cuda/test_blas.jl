using CuArrays

function test_01()

    N = 50

    A = CuArray( rand(ComplexF64,N) )
    B = CuArray{ComplexF64}(undef, N)

    CuArrays.CUBLAS.blascopy!( N, A, 1, B, 1 )

    println("test_01 is finished")
end

test_01()