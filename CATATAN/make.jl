using Documenter, MyPkg

makedocs(
    clean = false,
    format = :html,
    sitename = "Pengenalan Bahasa Pemrograman Julia",
    authors = "Julia Development Team dan Fadjar Fathurrahman",
    pages = Any[
        "Pendahuluan" => "index.md",
        "TutorialSingkat" => "TutorialSingkat.md",
        "Manual" => Any[
            "Variabel.md",
            "IntegerDanFloat.md",
            "OperasiMatematika.md",
            "KompleksDanRasional.md",
            "String.md",
            "Fungsi.md",
            "AlurKontrol.md",
            "RuangLingkupVariabel.md",
            "Tipe.md",
            "Metode.md",
            "Konstruktor.md",
            "KonversiDanPromosi.md",
            "Interface.md",
            "Modul.md",
            "Dokumentasi.md",
            "Metaprogramming.md",
            "ArrayMultiDim.md",
            "AljabarLinear.md",
            "JaringanDanStream.md",
            "KomputasiParalel.md",
            "DateDanDateTime.md"
        ],
        "Paket Julia" => Any[
            "PyPlot.md"
        ]
    ],
    html_prettyurls = true,
)
