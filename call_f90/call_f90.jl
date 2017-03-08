# compile the module with
# gfortran -fPIC -shared -O2 module1.f90 -o module1.so

ccall( (:__mymodule_MOD_init_mymodule, "module1.so"), Void, () )

mm = ccall( (:__mymodule_MOD_five, "module1.so"), Int, () )
println(mm)

Ptr_gbl_R = cglobal( (:__mymodule_MOD_gbl_r, "module1.so"), Float64 )
gbl_R = unsafe_load(Ptr_gbl_R)
println(gbl_R)
unsafe_store!(Ptr_gbl_R,9.0)

nn = ccall( (:__mymodule_MOD_get_gbl_r, "module1.so"), Float64, () )
println(nn)

Ptr_gbl_Arr1 = cglobal( (:__mymodule_MOD_gbl_arr1, "module1.so"), Float64 )
gbl_Arr1 = unsafe_load(Ptr_gbl_Arr1,3)
println(gbl_Arr1)
