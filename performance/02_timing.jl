function my_func(N::Int)
    x = zeros(N)
    for i in 1:N
        x[i] = rand() + sin(x[i]) + cos(rand())
    end
    C = my_func_02()
    #sleep(1.0)
    return
end

function my_func_02(; A=rand(100,100), B=rand(100,200))
    return A*B
end

@my_time my_func(1_000_000)
@my_time my_func(1_000_000)