const PREAMBLE = raw"
\documentclass[a4paper,12pt,fleqn]{article}
\usepackage[a4paper]{geometry}

\setlength{\parskip}{\smallskipamount}
\setlength{\parindent}{0pt}

\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{braket}

\usepackage[libertine]{newtxmath}
\usepackage[no-math]{fontspec}
\setmainfont{Linux Libertine O}
\setmonofont{JuliaMono-Regular}

\usepackage{hyperref}
\usepackage{url}
\usepackage{xcolor}

\usepackage{mhchem}

\usepackage{minted}
\newminted{julia}{breaklines,texcomments,fontsize=\footnotesize}
\newminted{text}{breaklines,fontsize=\footnotesize}

\newcommand{\txtinline}[1]{\mintinline[fontsize=\footnotesize]{text}{#1}}
\newcommand{\jlinline}[1]{\mintinline[fontsize=\footnotesize]{julia}{#1}}

\definecolor{mintedbg}{rgb}{0.95,0.95,0.95}
\usepackage{mdframed}

\BeforeBeginEnvironment{minted}{\begin{mdframed}[backgroundcolor=mintedbg,%
  rightline=false,leftline=false,topline=false,bottomline=false]}
\AfterEndEnvironment{minted}{\end{mdframed}}

\begin{document}
"


function main()
    lines = readlines("example_codes_01.jl")
    f = open("OUT.tex", "w")
    println(f, PREAMBLE)
    println("Number of lines read: ", length(lines))
    idx_line = 0
    while idx_line <= length(lines)
        idx_line += 1
        println("Main prog: idx_line ", idx_line)
        if occursin("#=", lines[idx_line])
            idx_line = handle_multiline(f, lines, idx_line)
            println("After handle_multiline: ", idx_line)
            if idx_line >= length(lines)
                break
            end
        else
            idx_line = handle_code(f, lines, idx_line)
            println("After handle_code: ", idx_line)
            if idx_line >= length(lines)
                break
            end
        end
    end
    println(f, "\\end{document}")
    close(f)
end

function handle_multiline(f, lines, idx_line)
    #println("Handle multiline comments")
    latex_lines = ""
    while idx_line <= length(lines)
        # Next line
        idx_line += 1
        l = lines[idx_line]
        if occursin("=#", l)
            #println("Found end of multiline")
            break
        end
        println(f, l)
    end
    return idx_line
end

function handle_code(f, lines, idx_line)
    #println("Handle multiline code")
    println(f, "\\begin{juliacode}")
    #println("Initial idx_line = ", idx_line)
    while idx_line <= length(lines)
        # Next line
        l = lines[idx_line]
        println("In handle_code: idx_line = ", idx_line)
        if occursin("#=", l)
            #println("Found beginning of comment")
            break
        end
        println(f, l)
        idx_line = idx_line + 1
    end
    println(f, "\\end{juliacode}")
    return idx_line - 1
end

main()

