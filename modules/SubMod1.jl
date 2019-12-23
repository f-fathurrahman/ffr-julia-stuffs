module SubMod1

using ..Mod1

# extend f1
function f1( x, y )
    return Mod1.f1(x) + Mod1.f1(y)
end


end