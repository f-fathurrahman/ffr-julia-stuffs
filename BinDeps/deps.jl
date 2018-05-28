# This is an auto-generated file; do not edit

# Pre-hooks

if VERSION >= v"0.7.0-DEV.3382"
    using Libdl
end
# Macro to load a library
macro checked_lib(libname, path)
    if Libdl.dlopen_e(path) == C_NULL
        error("Unable to load \n\n$libname ($path)\n\nPlease ",
              "re-run Pkg.build(package), and restart Julia.")
    end
    quote
        const $(esc(libname)) = $path
    end
end

# Load dependencies
@checked_lib libxc "/home/efefer/mysoftwares/libxc-3.0.0/lib/libxc.so"

# Load-hooks

