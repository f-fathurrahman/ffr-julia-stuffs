module MyModule

IMPLICIT NONE

INTEGER, PARAMETER :: MYPARAM1 = 4
REAL(8) :: gbl_R = 8.d0
REAL(8) :: gbl_Arr1(3)
REAL(8) :: gbl_Arr2(4,3)
REAL(8), ALLOCATABLE :: gbl_Arr3(:,:)
REAL(8), ALLOCATABLE :: gbl_Arr4(:,:,:)
REAL(8), ALLOCATABLE :: gbl_Arr5(:,:,:)

LOGICAL :: gbl_flag1
CHARACTER :: gbl_char1
CHARACTER(256) :: gbl_str1

TYPE MyType_T
  INTEGER :: Ndata
  REAL(8), ALLOCATABLE :: D2jl(:,:)
END TYPE

TYPE(MyType_T) :: mytype

CONTAINS


!-------------------------
SUBROUTINE init_MyModule()
!-------------------------
  gbl_Arr1 = (/ 1.1d0, 2.2d0, 3.4d0 /)
  gbl_Arr2(1,:) = (/ 1.1d0, 2.2d0, 3.4d0 /)
  gbl_Arr2(2,:) = (/ 2.1d0, 2.3d0, 4.4d0 /)
  gbl_Arr2(3,:) = (/ 3.1d0, 2.4d0, 5.4d0 /)
  gbl_Arr2(4,:) = (/ 4.1d0, 2.5d0, 6.4d0 /)

  allocate(gbl_Arr3(3,4))
  gbl_Arr3(1,:) = 1.1d0
  gbl_Arr3(2,:) = 2.1d0
  gbl_Arr3(3,:) = 3.1d0

  allocate(gbl_Arr4(3,4,2))
  gbl_Arr4(1,:,:) = 1.1d0
  gbl_Arr4(2,:,:) = 2.1d0
  gbl_Arr4(3,:,:) = 3.1d0

  allocate(gbl_Arr5(1:3,-3:3,1:2))
  !allocate(gbl_Arr5(1:3,1:7,1:2))
  !allocate(gbl_Arr5(1:3,-1:5,1:2))
  gbl_Arr5(:,:,:) = 777.d0
  gbl_Arr5(1,0,2) = 999.d0

  gbl_flag1 = .true.
  gbl_char1 = 'F'
  gbl_str1 = 'this is a string'
END SUBROUTINE


!-----------------------------
subroutine finalize_MyModule()
!-----------------------------
  deallocate(gbl_Arr3)
  deallocate(gbl_Arr4)
  deallocate(gbl_Arr5)
end subroutine



!--------------------------------------
subroutine calc_something01(N, a, b, c)
!--------------------------------------
  integer :: N
  real(8) :: a(N)
  real(8) :: b(N)
  real(8) :: c(N)

  c(:) = a(:) + b(:)
  return
end subroutine


!-------------------------------------
subroutine calc_something02(N, a, b, c)
!--------------------------------------
  integer(8) :: N
  real(8) :: a(N)
  real(8) :: b(N)
  real(8) :: c(N)

  write(*,*) 'c = ', c
  return
end subroutine


!-------------------------------------
subroutine calc_something03(N)
!--------------------------------------
  integer(8) :: N
  write(*,*) 'N = ', N
  return
end subroutine



!----------------------
INTEGER FUNCTION five()
!----------------------
  five = 5
END FUNCTION


!---------------------------
REAL(8) FUNCTION get_gbl_R()
!---------------------------
  get_gbl_R = gbl_R
END FUNCTION

END MODULE
