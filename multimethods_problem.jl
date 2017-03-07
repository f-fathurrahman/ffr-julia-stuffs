# Library
abstract bar

ex(x) = println("dynamic")
ex(x::bar) = println("bar")

test(x::bar) = ex(x)

type foo <: bar
  x :: Int
end

test(foo(5))

# Now our code
ex(x::foo) = println("foo")

test(foo(5))

