if VERSION > v"0.6.2"
    using LinearAlgebra
end

function test_matmul()
    v1 = rand(200,4)
    A = rand(400,40)
    B = rand(400,40)
    C = A*B'
end
test_matmul()
@time test_matmul()

function test_det()
    A = rand(3,3)
    Ω = det(A')
end
test_det()
@time test_det()

function test_tr()
    v2 = rand(200,4)
    z1 = tr(v2'*v2)
    z2 = sum(v1.*v2)
    @assert abs(z1 - z2) > eps()
end
test_tr()
@time test_tr()