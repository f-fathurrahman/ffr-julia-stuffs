fileout = open("TEMP_log", "w")

old_stdout = stdout
redirect_stdout( fileout )
println("This will be printed in file")

redirect_stdout(old_stdout)
println("This will be printed in stdout")

close(fileout)

fileout = open("TEMP_log_2", "w")
redirect_stdout( fileout )
println("This will be printed in the second file")
close(fileout)

redirect_stdout( old_stdout )
println("This is also printed in stdout")
