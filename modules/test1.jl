push!(LOAD_PATH, pwd())
using Mod1

function test1()
  x = Mod1.f1(2.1)
  @printf("Hello World: %f\n", x)
end

test1()
