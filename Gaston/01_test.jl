import Gaston

function test_main()
    x = Array(linspace(0,1,100))
    y = sin.(pi*x/0.5)
    Gaston.set( terminal="x11" )
    h1 = Gaston.plot(x,y)
    Gaston.printfigure( handle=h1, term="pdf", outputfile="plot1.pdf" )
end

test_main()

