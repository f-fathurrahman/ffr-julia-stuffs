level = 0

function showtypetree(subtype)
  global level
  subtypelist = filter(asubtype -> asubtype != Any, subtypes(subtype))
  if length(subtypelist) > 0
    println("\t" ^ level, subtype)
    level += 1
    map(showtypetree, subtypelist)
    level -= 1
  else
    println("\t" ^ level, subtype)
  end
end

showtypetree(Number)

