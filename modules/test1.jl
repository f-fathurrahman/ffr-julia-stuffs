push!(LOAD_PATH, pwd())

using Printf
using Mod1

function test1()
  x = Mod1.f1(2.1)
  @printf("Hello World: %f\n", x)

  y = Mod1.SubMod1.f1(2.1, 3.4)
  @printf("From SubMod1: %f\n", y)
end

test1()
