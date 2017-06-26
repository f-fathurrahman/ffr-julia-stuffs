function test_main()

  mytupletype = Tuple{AbstractString, Vararg{Int}}

  println(mytupletype)

  println( isa( ("1",), mytupletype ) )
  println( isa( ("1", 1), mytupletype ) )
  println( isa( ("1", 1, 2), mytupletype ) )
  println( isa( ("1",1, 2, 3), mytupletype ) )

  println( isa( ("1",1, 2, 3.1), mytupletype ) )

end

test_main()
