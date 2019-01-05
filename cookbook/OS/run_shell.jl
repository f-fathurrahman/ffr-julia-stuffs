my_cmd = `cat identify_os_type.jl`

println("typeof my_cmd: ", typeof(my_cmd))

println()
println("Running cat to show the content of identify_os_type.jl")
println()
run(`cat identify_os_type.jl`)

