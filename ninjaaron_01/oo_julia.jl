# Composite data types in Julia

struct Point
    x::Float64
    y::Float64
end

mypoint = Point(5, 7)

# access the fields
println("mypoint.x = ", mypoint.x)
println("mypoint.y = ", mypoint.y)

# we can't set the field of Point because it is immutable by default
# mypoint.x = 5.0 # -> will give error

mutable struct Starship
    name::String
    location::Point
end

ship = Starship("U.S.S. Enterprise", Point(6,5))
println("ship = ", ship)

# we can move the ship by changing the location
ship.location = Point(7,10)
println("ship (moved) = ", ship)

# Alternative constructor for Starship
Starship(name, x, y) = Starship(name, Point(x,y))

othership = Starship("U.S.S. Defiant", 10, 2)
println("othership = ", othership)

# example of internal (inner) constructors
# (used in the creation of new structs, using `new`)
mutable struct FancyStarship
    name::String
    location::Point
    FancyStarship(name, x, y) = new(name, Point(x,y))
end

fancy_ship = FancyStarship("U.S.S. Discovery", 14, 25)
println("fancy_ship = ", fancy_ship)

# However, we cannot do this with inner constructor
# FancyStarship("U.S.S. Ticonderoga", Point(14,32))
# => adding internal constructors means the basis constructor is no longer available
#    to the outside.


# Function to move a Starship
function move!( starship, heading, distance )
    old = starship.location
    Δx = distance*cosd(heading)
    Δy = distance*cosd(heading)
    starship.location = Point(old.x + Δx, old.y + Δy)
    return
end

ship = Starship("Foo", 3, 4)
move!(ship, 45.0, 30.0)
println(ship)

# We can add additional methods to any function

struct Rectangle
    width::Float64
    height::Float64
end

width( r::Rectangle ) = r.width
height( r::Rectangle ) = r.height

struct Square
    length::Float64
end

width( s::Square ) = s.length
height( s::Square ) = s.length

area( shape ) = width(shape) * height(shape)

r = Rectangle(3,4)
s = Square(3)

@show area(r)
@show area(s)

