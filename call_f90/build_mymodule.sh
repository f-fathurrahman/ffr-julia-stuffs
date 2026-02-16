#gfortran -fPIC -c MyModule.f90
#gfortran -fPIC -c subroutines.f90
#gfortran -fPIC -shared MyModule.o subroutines.o -o libmymodule.so

gfortran -fPIC -shared MyModule.f90 -o libmymodule.so
