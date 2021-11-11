function example()
    println("This is an example")
    return
end

"""
    my_func(α, β)

An example function.
Compute `α + β`. 
"""
function myfunc(α, β)
    return α + β
end

function myfunc02!(X)
    X.a = 1.0
    X.b = 2.1
    return
end