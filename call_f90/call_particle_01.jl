lib = "./libparticle.so"

ccall((:init_particle, lib), Cvoid, (Cdouble,Cdouble,Cdouble), 1.0,2.0,5.0)

x = ccall((:get_x, lib), Cdouble, ())
y = ccall((:get_y, lib), Cdouble, ())
m = ccall((:get_mass, lib), Cdouble, ())

println((x,y,m))


