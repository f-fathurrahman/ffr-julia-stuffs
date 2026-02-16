struct Particle
    x::Cdouble
    y::Cdouble
    mass::Cdouble
end

ccall((:init_particle_default,"./libparticle.so"), Cvoid, ())

ptr = ccall((:get_particle,"./libparticle.so"), Ptr{Particle}, ())
p = unsafe_load(ptr)

println("p.x=$(p.x), p.y=$(p.y), p.mass=$(p.mass)")

