my_cmd = `cat identify_os_type.jl`

println("typeof my_cmd: ", typeof(my_cmd))

println("I will run: ", my_cmd)
run(my_cmd)

