using Documenter, MyPkg

makedocs(
    clean = false,
    format = :html,
    sitename = "Pengenalan Bahasa Pemrograman Julia",
    authors = "Fadjar Fathurrahman",
    pages = Any[
        "Home" => "index.md",
        "Tipe" => "Tipe.md"
    ],
    html_prettyurls = true,
)
