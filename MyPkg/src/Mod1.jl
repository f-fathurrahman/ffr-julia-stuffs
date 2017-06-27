module Mod1

function hello(name::AbstractString)
  @printf("Hello %s. I am Mod1.\n", name)
end

end
