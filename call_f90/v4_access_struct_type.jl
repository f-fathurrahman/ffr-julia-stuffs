ccall( (:__mymodule_MOD_init_mymodule, "module1.so"), Cvoid, () )

struct MyTypeStruct
    Ndata::Int32
    D2jl::Matrix{Float64}
end

#struct MyTypeStruct
#    Ndata::Int32
#    D2jl::Ptr{Float64}
#end

ptr = cglobal( (:__mymodule_MOD_mytype, "module1.so"), Ptr{MyTypeStruct} )
