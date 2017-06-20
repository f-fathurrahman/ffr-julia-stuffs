__precompile__()

module MyPkg

export my_function, my_second_function, welcome

function welcome()
   println(" __  __       ____  _")
   println("|  \\/  |_   _|  _ \\| | ____ _")
   println("| |\\/| | | | | |_) | |/ / _` |")
   println("| |  | | |_| |  __/|   < (_| |")
   println("|_|  |_|\\__, |_|   |_|\\_\\__, |")
   println("        |___/           |___/ ")
end

function my_function()
  println("Hello, I am my_function from MyPkg")
end

function my_second_function()
  println("And this is my second function")
  println("Yeay")
end

end
