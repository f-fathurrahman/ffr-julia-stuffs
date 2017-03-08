using LightXML

xdoc = parse_file("Ni.pbe-nd-rrkjus.UPF");
xroot = root(xdoc);

upf_pp_mesh = get_elements_by_tagname( xroot, "PP_MESH" )
upf_pp_r = get_elements_by_tagname( upf_pp_mesh[1], "PP_R")
@printf "typeof(pp_r) = %s\n" typeof(upf_pp_r)
text1 = replace( content(upf_pp_r[1]), "\n", " " )
str1 = split( text1 )
Nstr1 = length( str1 )
#@printf "len of str1 = %d\n" length(str1)
#println(text1)
#pp_r = readdlm( IOBuffer(text1), Float64 )  # not working?
pp_r = zeros(Nstr1)
for i = 1:Nstr1
  pp_r[i] = float( str1[i] )
end
println(typeof(pp_r))

