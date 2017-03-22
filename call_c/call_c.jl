# compile the module with
# gcc -fPIC -shared -O2 test_fftw3.c -o cfftw.so

ccall( (:test03, "./cfftw3.so"), Void, () )
