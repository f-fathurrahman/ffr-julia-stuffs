# compile the module with
# gfortran -fPIC -shared -O2 module1.f90 -o module1.so

ccall( (:__mymodule_MOD_init_mymodule, "module1.so"), Cvoid, () )

mm = ccall( (:__mymodule_MOD_five, "module1.so"), Int, () )
println(mm)

Ptr_gbl_R = cglobal( (:__mymodule_MOD_gbl_r, "module1.so"), Float64 )
gbl_R = unsafe_load(Ptr_gbl_R)
println(gbl_R)
unsafe_store!(Ptr_gbl_R,9.0)

nn = ccall( (:__mymodule_MOD_get_gbl_r, "module1.so"), Float64, () )
println(nn)

Ptr_gbl_Arr1 = cglobal( (:__mymodule_MOD_gbl_arr1, "module1.so"), Float64 )
gbl_Arr1 = unsafe_load(Ptr_gbl_Arr1,3) # only 3rd index is loaded
println(gbl_Arr1)

Ptr_gbl_Arr2 = cglobal( (:__mymodule_MOD_gbl_arr2, "module1.so"), Float64 )
gbl_Arr2 = unsafe_wrap(Array{Float64,2}, Ptr_gbl_Arr2, (4,3))
println(gbl_Arr2)

Ptr_gbl_Arr3 = cglobal( (:__mymodule_MOD_gbl_arr3, "module1.so"), Ptr{Float64} )
gbl_Arr3 = zeros(Float64,3*4)
ip = 1
for j in 1:4, i in 1:3
    gbl_Arr3[ip] = unsafe_load(unsafe_load(Ptr_gbl_Arr3,1),ip)
    ip = ip + 1
end
gbl_Arr3 = reshape(gbl_Arr3,(3,4))
display(gbl_Arr3); println()

Ptr_gbl_Arr4 = cglobal( (:__mymodule_MOD_gbl_arr4, "module1.so"), Ptr{Float64} )
gbl_Arr4 = zeros(Float64,3*4*2)
ip = 1
for k in 1:2, j in 1:4, i in 1:3
    gbl_Arr4[ip] = unsafe_load(unsafe_load(Ptr_gbl_Arr4,1),ip)
    ip = ip + 1
end
gbl_Arr4 = reshape(gbl_Arr4,(3,4,2))
display(gbl_Arr4); println()