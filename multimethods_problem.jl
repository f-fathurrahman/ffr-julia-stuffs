# Library
abstract type bar end

ex(x) = println("dynamic")
ex(x::bar) = println("bar")

test(x::bar) = ex(x)

struct foo <: bar
  x :: Int
end

test(foo(5))

# Now our code
ex(x::foo) = println("foo")

test(foo(5))

