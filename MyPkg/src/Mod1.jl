module Mod1

using Printf

function hello( name::String )
  @printf("Hello %s. I am Mod1.\n", name)
end

end
