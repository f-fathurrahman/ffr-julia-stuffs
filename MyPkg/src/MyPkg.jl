__precompile__()

module MyPkg

export my_function, my_second_function, welcome

doc"""
This is an example documentation.

```julia-repl
julia> using MyPkg

julia> welcome()
```
"""
function welcome()
   println(" __  __       ____  _")
   println("|  \\/  |_   _|  _ \\| | ____ _")
   println("| |\\/| | | | | |_) | |/ / _` |")
   println("| |  | | |_| |  __/|   < (_| |")
   println("|_|  |_|\\__, |_|   |_|\\_\\__, |")
   println("        |___/           |___/ ")
end

doc"""
Another dummy function. Simply display some message to screen.

Using LaTeX, inline equation: $\beta + \frac{1}{2x}$.
"""
function my_function()
  println("Hello, I am my_function from MyPkg")
end

"""
My second function. Display two lines of message.
"""
function my_second_function()
  println("And this is my second function")
  println("Yeay")
end

end
