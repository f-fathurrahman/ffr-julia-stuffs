using Documenter

makedocs(
    sitename = "Learning Documenter",
    pages = [
        "Home" => "index.md",
        "Getting started" => [
            "intro.md",
            "install.md"
        ],
        "Tutorial" => [
            "tutor1.md",
            "tutor2.md"
        ],
        #"Theory" => [
        #    "theory1.md",
        #    "theory2.md"
        #],
    ],
    format = Documenter.LaTeX()
)