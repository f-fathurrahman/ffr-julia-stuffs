const MYLIB = "./libmymodule.so"

function load_allocatable_array(symbol::Symbol, T::DataType, shape)
    @assert T == Float64
    ptr = cglobal( (symbol, MYLIB), Ptr{T} )
    tmp = zeros(T, prod(shape))
    for ip in 1:prod(shape)
        tmp[ip] = unsafe_load(unsafe_load(ptr,1),ip)
    end
    return reshape(tmp, shape)
end

function get_x()
    return unsafe_load(cglobal( (:__mymodule_MOD_x, MYLIB), Float64 ))
end

function get_x_v2()
    symb = :__mymodule_MOD_x
    return unsafe_load(cglobal( (symb, MYLIB), Float64 ))
end

function get_x_v3()
    symb = :__mymodule_MOD_x
    ptr = cglobal((symb, MYLIB), Float64)
    return ptr
end

function get_Nsize()
    return unsafe_load(cglobal( (:__mymodule_MOD_nsize, MYLIB), Int32 )) |> Int64 
end

# Should be called only once
ccall( (:initialize_mymodule_, MYLIB), Cvoid, () )

x = get_x()
#x = get_x_v2() # will crash
#x = unsafe_load(get_x_v3()) # will also crash
println("x = ", x)

Nsize = get_Nsize()
symb = :__mymodule_MOD_v
v = load_allocatable_array(symb, Float64, (Nsize,))
println("v = ", v)