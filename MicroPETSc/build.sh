#!/bin/bash

PETSC_DIR=/opt/petsc-3.11.3_openmpi-2.2.1_debug

if [ "$#" -eq 1 ]; then

  basnam=`basename $1 .c`
  mpicc.openmpi $1 -I${PETSC_DIR}/include -L${PETSC_DIR}/lib -lpetsc -o $basnam.x -lm
  # -lblas -llapack -lm -lX11 -ldl

else

  echo "Wrong number of arguments: $#"

fi

