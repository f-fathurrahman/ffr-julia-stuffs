using Printf

struct MyCoolDatatype
    x::Float64
    y::Float64
    z::ComplexF64
end

import Base: show
function show(io::IO, d::MyCoolDatatype; header=true)
    if header
        @printf(io, "\n")
        @printf(io, "--- MyCoolDatatype ---\n")
        @printf(io, "\n")
    end
    @printf(io, "This is x = %18.10f\n", d.x)
    @printf(io, "This is y = %18.10f\n", d.y)
    @printf(io, "This is z = [%18.10f,%18.10f]\n", real(d.z), imag(d.z))
end

show( d::MyCoolDatatype; header=true ) = show( stdout, d, header=header )

import Base: println
println( d::MyCoolDatatype; header=true ) = show( stdout, d, header=header )

function test_main()
    d1 = MyCoolDatatype(0.0, 1.0, 1.0 + 2.0im)
    println(d1)
    show(d1, header=false)
    println(d1, header=false)
end

test_main()