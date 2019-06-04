using CuArrays
using FFTW

A = rand(1024,1024)
d_A = cu(A)

for i in 1:2
    println("Using CPU")
    @time fft(A)
    println("Using GPU")
    @time fft(d_A)
end
