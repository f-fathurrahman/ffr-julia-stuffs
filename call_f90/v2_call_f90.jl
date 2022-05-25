ccall( (:__mymodule_MOD_init_mymodule, "module1.so"), Cvoid, () )

# Read a ComplexF64 array (2d)
ptr = cglobal( (:__mymodule_MOD_zarr1, "module1.so"), Ptr{ComplexF64} )
Ndim1 = 3
Ndim2 = 4
tmp = zeros(ComplexF64,Ndim1*Ndim2)
ip = 1
for j in 1:Ndim2, i in 1:Ndim1
    tmp[ip] = unsafe_load(unsafe_load(ptr,1),ip)
    ip = ip + 1
end
zarr1 = reshape(tmp, (Ndim1,Ndim2))
display(zarr1); println()
