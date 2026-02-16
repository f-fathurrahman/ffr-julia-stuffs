module particle_mod
  use iso_c_binding
  implicit none

!  type :: particle
!     real(c_double) :: x
!     real(c_double) :: y
!     real(c_double) :: mass
!  end type particle

type, bind(C) :: particle
   real(c_double) :: x
   real(c_double) :: y
   real(c_double) :: mass
end type

  type(particle), target, save :: p

contains

  subroutine init_particle_default() bind(C,name="init_particle_default")
    p%x = 1.d0
    p%y = 2.3d0
    p%mass = 4.4d0
    write(*,*) 'Particle initialized with default parameters'
  end subroutine


  subroutine init_particle(x,y,m) bind(C,name="init_particle")
    real(c_double), value :: x,y,m
    p%x = x
    p%y = y
    p%mass = m
  end subroutine

  function get_x() result(val) bind(C,name="get_x")
    real(c_double) :: val
    val = p%x
  end function

  function get_y() result(val) bind(C,name="get_y")
    real(c_double) :: val
    val = p%y
  end function

  function get_mass() result(val) bind(C,name="get_mass")
    real(c_double) :: val
    val = p%mass
  end function


  function get_particle() result(ptr) bind(C,name="get_particle")
    type(c_ptr) :: ptr
    ptr = c_loc(p)
  end function

end module



