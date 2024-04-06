function get_var1()
    return rand(3)
end

function get_var2()
    return randn(7)
end

function build_expr_prog1(v)
    str_prog = """$v = get_$v()"""
    return Meta.parse(str_prog)
end

function build_expr_prog2(v)
    str_prog = """println("$v = ", $v)"""
    return Meta.parse(str_prog)
end

function main()
    for v in (:var1, :var2)
        eval(build_expr_prog1(v))
        eval(build_expr_prog2(v))
    end
end
#main()


# Need to use begin end for multiline expression
function build_expr_prog_all(s::Symbol)
    str_prog = """
    begin
    $s = get_$s()
    println("Value of $s = ", $s)
    end
    """
    return str_prog
end
