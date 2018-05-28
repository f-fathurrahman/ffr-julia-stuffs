abstract type Contact
  name :: AbstractString
  email :: AbstractString
  phone :: AbstractString


  # Inner constructor
  function Contact(name::AbstractString, email::AbstractString, phone::AbstractString)
    #
    length(name) == 0 && error("Need to provide contact name")
    #
    length(email) == 0 && length(phone) == 0 && error("Need to provide either an email or a phone number")
    #
    new(name, email, phone)
  end
end

# introcude a hiearchy of abstract types
abstract Vehicle
abstract Car <: Vehicle
abstract Bike <: Vehicle
abstract Boat <: Vehicle
abstract Powerboat <: Boat


abstract type Ford <: Car
  owner:: Contact
  model:: AbstractString
  fuel:: AbstractString
  color:: AbstractString
  engine_cc:: Int64
  speed_mph:: Float64

  function Ford(owner:: Contact, model:: AbstractString, 
         engine_cc:: AbstractString, speed_mph:: AbstractString)
    new(owner, model, "Petrol", "Black", engine_cc, speed_mph )
  end
end


type BMW <: Car
  owner:: Contact
  model:: AbstractString
  fuel:: AbstractString
  color:: AbstractString
end


