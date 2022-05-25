ccall( (:__mymodule_MOD_init_mymodule, "module1.so"), Cvoid, () )

# Read an integer (Int32) array (1d), allocatable
ptr = cglobal( (:__mymodule_MOD_iarr1, "module1.so"), Ptr{Int32} )
Ndim1 = 4
iarr1 = zeros(Int64,Ndim1)
ip = 1
for i in 1:Ndim1
    iarr1[ip] = Int64(unsafe_load(unsafe_load(ptr,1),ip))
    ip = ip + 1
end
display(iarr1); println()
