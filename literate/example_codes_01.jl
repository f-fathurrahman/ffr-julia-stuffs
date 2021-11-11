function example()
    println("This is an example")
    return
end
#=

This is an example codes

\begin{equation}
\alpha + \beta + \frac{1}{2} + \alpha_{1} + \zeta
\end{equation}

=#

"""
    my_func(α, β)

An example function.
Compute `α + β`. 
"""
function myfunc(α, β)
    return α + β
end

function myfunc02!(X)
#=
Suddenly a code again.
$\alpha + \beta$
=#
    X.a = 1.0 # This comment is rendered in LaTex
    X.b = 2.1
    return
end