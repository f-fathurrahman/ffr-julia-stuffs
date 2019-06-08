using QuadGK
using SpecialFunctions
using Printf

function my_func(x)
    return exp(-0.5*x^2)
end

function gauss_pot(r, Gm, Zs)
    return Zs * erf(r) * sin(r*Gm)/Gm
end

function test_gaussian()
    res = quadgk(my_func, -Inf, Inf, rtol=1e-10)
    println("res = ", res)
    println( typeof(res) )
    println( res[1]/sqrt(2*pi) )
end

function test_erf()
    Gm = 1.0
    Zs = 1.0

    res = quadgk( r -> Zs * erf(r) * sin(r*Gm)/Gm, 0.0, 10 )
    println("res = ", res)
 
    res = quadgk( r -> Zs * erf(r) * sin(r*Gm)/Gm, 0.0, 100 )
    println("res = ", res)

    #res = quadgk( r -> Zs * erf(r) * sin(r*Gm)/Gm, 1.0, 500000 )
    #println("res = ", res)
    
end

function gen_data_erf()
    Δr = 0.1
    r0 = 0.0
    Gm = 1.0
    Zs = 1.0
    for i = 0:10000
        r = r0 + Δr*i
        @printf("%18.10f %18.10f\n", r, gauss_pot(r, Gm, Zs))
    end
end

#gen_data_erf()

test_erf()
#test_gaussian()


