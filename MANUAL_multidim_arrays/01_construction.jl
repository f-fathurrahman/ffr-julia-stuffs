struct MyType
    x::Int
    y::Int
end # struct MyType


"""
Explore how the initial values of an array initialized with `undef`
with various data type.
"""
function test01()
    
    # Built-in types
    for typ in (Int32, Int64, Float64, ComplexF64, Bool)
        println("\nType = ", typ)
        A = Array{typ}(undef,3,3)
        println(A)
    end

    # Using user-defined type
    println("\nType = ", MyType)
    A = Array{MyType}(undef,3,3)
    println(A)
end

test01()
