using Documenter, MyPkg

makedocs(
    modules = [MyPkg],
    clean = false,
    format = :html,
    sitename = "MyPkg.jl",
    authors = "Fadjar Fathurrahman",
    pages = Any[
        "Home" => "index.md",
    ],
    html_prettyurls = true,
)
