using Documenter, MyPkg

makedocs(
    clean = false,
    format = :html,
    sitename = "Pengenalan Bahasa Pemrograman Julia",
    authors = "Julia Development Team dan Fadjar Fathurrahman",
    pages = Any[
        "Home" => "index.md",
        "TutorialSingkat" => "TutorialSingkat.md",
        "Variabel" => "Variabel.md",
        "Tipe" => "Tipe.md",
    ],
    html_prettyurls = true,
)
