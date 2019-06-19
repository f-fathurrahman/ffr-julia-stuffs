struct HasInterestingField{T}
    data::T
end

double( hif::HasInterestingField ) = hif.data*2
shout( hif::HasInterestingField ) = uppercase(string(hif.data, "!"))

# the compositional way add those attributes to another struct
struct WantsInterestingField{T}
    interesting::HasInterestingField{T}
    WantsInterestingField(data::T) where T = new{T}(HasInterestingField(data))
end

# forward methods
for method in (:double, :shout)
    @eval $method( wif::WantsInterestingField ) = $method( wif.interesting )
end
# This is the same as:
#     double(wif::WantsInterestingField) = double(wif.interesting)
#     shout(wif::WantsInterestingField) = shout(wif.interesting)

wif = WantsInterestingField("foo")
@show shout( wif )

wif_again = WantsInterestingField(2.3)
@show double( wif_again )

