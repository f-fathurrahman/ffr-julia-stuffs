using BinDeps

@BinDeps.setup

libxc = library_dependency("libxc")
println("libxc = ", libxc)
println("Pass here")

@BinDeps.install Dict(:libxc => :libxc)
