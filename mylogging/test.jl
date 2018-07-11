push!( LOAD_PATH, "./" )

using Printf

using MyPkg
using MyPkg.Logging: LOGFILE


function init_logging(filename)
    LOGFILE = open(filename, "w")
end

function using_logging()
    #init_logging("LOGGGG")
    @printf(LOGFILE, "This is an info\n")
    close(LOGFILE)
end

function using_file()
    f = open("LOG11", "w")
    @printf(f, "This is an info\n")
    close(f)
end

using BenchmarkTools
@btime using_logging()
@btime using_file()

