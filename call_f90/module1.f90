module MyModule

IMPLICIT NONE

INTEGER, PARAMETER :: MYPARAM1 = 4
REAL(8) :: gbl_R = 8.d0
REAL(8) :: gbl_Arr1(3)

TYPE MyType_T
  INTEGER :: Ndata
  REAL(8), ALLOCATABLE :: D2jl(:,:)
END TYPE

TYPE(MyType_T) :: mytype

CONTAINS

SUBROUTINE init_MyModule()
  gbl_Arr1 = (/ 1.1d0, 2.2d0, 3.4d0 /)
END SUBROUTINE

INTEGER FUNCTION five()
  five = 5
END FUNCTION

REAL(8) FUNCTION get_gbl_R()
  get_gbl_R = gbl_R
END FUNCTION

END MODULE
