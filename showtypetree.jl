using InteractiveUtils

# Using global variable !!!
level = 0

function showtypetree(subtype)
    global level
    subtypelist = filter(asubtype -> asubtype != Any, subtypes(subtype))
    if length(subtypelist) > 0
      println("--" ^ level, subtype)
      level += 1
      map(showtypetree, subtypelist)
      level -= 1
    else
      println("--" ^ level, subtype)
    end
end

showtypetree(Number)
