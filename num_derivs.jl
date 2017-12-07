function numerical_derivative(f, x, dx=0.01)
    derivative = ( f(x+dx) - f(x-dx) )/(2*dx)
    return derivative
end

function fun1(x)
    return x^2 - 1.2*x + 3.2
end

@time dfun1 = numerical_derivative( fun1, 0.3 )
@time dfun1 = numerical_derivative( fun1, 0.3 )
println("dfun1 = ", dfun1)
