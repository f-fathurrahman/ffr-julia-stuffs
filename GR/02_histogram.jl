import GR

function main()
    GR.histogram( randn(10000) )
    GR.savefig( "TEMP_02_histogram.pdf" )
end

main()
