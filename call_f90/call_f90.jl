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

#
Ptr_gbl_Arr4 = cglobal( (:__mymodule_MOD_gbl_arr4, "module1.so"), Ptr{Float64} )
gbl_Arr4 = zeros(Float64,3*4*2)
ip = 1
for k in 1:2, j in 1:4, i in 1:3
    gbl_Arr4[ip] = unsafe_load(unsafe_load(Ptr_gbl_Arr4,1),ip)
    ip = ip + 1
end
gbl_Arr4 = reshape(gbl_Arr4,(3,4,2))
display(gbl_Arr4); println()


#
using OffsetArrays
Ptr_gbl_Arr5 = cglobal( (:__mymodule_MOD_gbl_arr5, "module1.so"), Ptr{Float64} )
Ndim1 = 3
Ndim2 = 7 # -3:3
Ndim3 = 2
gbl_Arr5 = zeros(Float64,Ndim1*Ndim2*Ndim3)
ip = 1
for k in 1:Ndim3, j in 1:Ndim2, i in 1:Ndim1
    gbl_Arr5[ip] = unsafe_load(unsafe_load(Ptr_gbl_Arr5,1),ip)
    ip = ip + 1
end
gbl_Arr5 = reshape(gbl_Arr5,(Ndim1,Ndim2,Ndim3))
gbl_Arr5 = OffsetArray(gbl_Arr5, 1:3, -3:3, 1:2)
display(gbl_Arr5); println()
println(gbl_Arr5[1,0,2])

# Read bool
ptr_gbl_flag1 = cglobal((:__mymodule_MOD_gbl_flag1, "module1.so"), Bool)
gbl_flag1 = unsafe_load(ptr_gbl_flag1)

# Read string (ASCII)
Ndim = 256
str1 = Vector{Char}(undef,Ndim)
ptr_gbl_str1 = cglobal((:__mymodule_MOD_gbl_str1, "module1.so"), Int8)
for i in 1:Ndim
    str1[i] = Char(unsafe_load(ptr_gbl_str1,i))
end
str1 = strip(String(str1)) # Convert to string

ptr_gbl_char1 = cglobal((:__mymodule_MOD_gbl_char1, "module1.so"), Int8)
char1 = Char(unsafe_load(ptr_gbl_char1))

