using Flux
using CSV, DataFrames

function main()
    model = Dense(2,1)
    apples = DataFrame(
        CSV.File("DATA/apples.dat", delim='\t', normalizenames=true ) )
    bananas = DataFrame(
        CSV.File( "DATA/bananas.dat", delim='\t' normalizenames=true ) )
end

main()
