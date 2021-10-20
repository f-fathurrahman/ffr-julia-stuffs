using Flux

function actual(x)
    return 4*x + 2
end

function main()
    x_train, x_test = hcat(0:5...), hcat(6:10...)
    y_train, y_test = actual.(x_train), actual.(x_test)

    # Model
    model = Dense(1,1)
    lossfunc(x,y) = Flux.Losses.mse(model(x), y)
    opt = Descent()
    data = [(x_train, y_train)]

    println("Initial model parameter")
    println(model.weight)
    println(model.bias)
    println("With initial model parameter:")
    println("x_train:")
    println(model(x_train))
    println("y_train:")
    println(model(y_train))
    println("Initial loss: ", lossfunc(x_train, y_train))

    for epoch in 1:200
        Flux.train!(lossfunc, params(model), data, opt)
    end


    println("After training current model parameter")
    println(model.weight)
    println(model.bias)
    println("After training current model parameter:")
    println("x_train:")
    println(model(x_train))
    println("y_train:")
    println(model(y_train))
    println("Current loss (train): ", lossfunc(x_train, y_train))
    println()
    println("x_test:")
    println(model(x_test))
    println("y_test:")
    println(model(y_test))
    println("Current loss (test): ", lossfunc(x_test, y_test))

end

main()