using Flux

actual(x) = 4x + 2

println( actual.([1, 2, 3]) )

x_train = hcat(0:5...) 
x_test = hcat(6:10...)

y_train = actual.(x_train)
y_test = actual.(x_test)

model = Dense(1,1)
println(model.weight)
println(model.bias)

predict = Dense(1,1)
println( predict(x_train) )

