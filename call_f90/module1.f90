module MyModule

IMPLICIT NONE

INTEGER, PARAMETER :: MYPARAM1 = 4
REAL(8) :: gbl_R = 8.d0
REAL(8) :: gbl_Arr1(3)
REAL(8) :: gbl_Arr2(4,3)

TYPE MyType_T
  INTEGER :: Ndata
  REAL(8), ALLOCATABLE :: D2jl(:,:)
END TYPE

TYPE(MyType_T) :: mytype

CONTAINS

SUBROUTINE init_MyModule()
  gbl_Arr1 = (/ 1.1d0, 2.2d0, 3.4d0 /)
  gbl_Arr2(1,:) = (/ 1.1d0, 2.2d0, 3.4d0 /)
  gbl_Arr2(2,:) = (/ 2.1d0, 2.3d0, 4.4d0 /)
  gbl_Arr2(3,:) = (/ 3.1d0, 2.4d0, 5.4d0 /)
  gbl_Arr2(4,:) = (/ 4.1d0, 2.5d0, 6.4d0 /)
END SUBROUTINE

INTEGER FUNCTION five()
  five = 5
END FUNCTION

REAL(8) FUNCTION get_gbl_R()
  get_gbl_R = gbl_R
END FUNCTION

END MODULE
