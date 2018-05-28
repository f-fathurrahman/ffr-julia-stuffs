function test_zip()
    a = 1:6
    b = ["a", "b", "c", "d", "e", "f"]
    c = zip(a,b)

    for cc in c
        println("cc = ", cc)
    end

    println("first(c) = ", first(c))
    println("length(c) = ", length(c))

end
#test_zip()

function test_enumerate()
    alphabets = rand(["a","b","c","d"],6)
    println("alphabets = ", alphabets)
    
    for (idx,item) in enumerate(alphabets)
        println("idx = ", idx, " item = ", item)
    end
end
#test_enumerate()

function test_rest()
    items = [3, 4, 5, 6, 1]
    c = Iterators.rest( items, 2 ) # the same as items[2:end]
    for cc in c
        println("cc = ", cc)
    end
    println(items[2:end])
end
@time test_rest()
@time test_rest()
