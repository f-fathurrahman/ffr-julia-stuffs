using Documenter

makedocs(
    sitename = "Learning Documenter",
    pages = [
        "Home" => "index.md",
        "Introduction" => "intro.md",
        "Theory" => "theory.md",
    ],
    format = Documenter.HTML()
)