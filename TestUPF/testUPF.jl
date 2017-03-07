using LightXML

xdoc = parse_file("Ni.pbe-nd-rrkjus.UPF");
xroot = root(xdoc);

@printf "xroot = %s\n" name(xroot)

# traverse all child nodes and print element names
for c in child_nodes( xroot )
  #println( nodetype(c) )
  if is_elementnode( c )
    elem = XMLElement( c )
    println( name(elem) )
  end
end


#ces = collect( child_elements(xroot) )
#@printf "Length of ces = %d\n" length(ces)

ces = get_elements_by_tagname( xroot, "PP_INFO" )
@printf "Length of ces = %d\n" length(ces)
@printf "typeof(ces) = %s\n" typeof(ces)

println( name(ces[1]) )
@printf "typeof(ces[1]) = %s\n" typeof(ces[1])

text1 = content( ces[1] )
@printf "typeof(text1) = %s\n" typeof(text1)

println(text1)
