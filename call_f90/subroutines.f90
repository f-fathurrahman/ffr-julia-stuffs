SUBROUTINE initialize_mymodule()
  USE MyModule
  IMPLICIT NONE
  integer :: i
  x = 1.23d0
  Nsize = 5
  if(.not. allocated(v)) then
    ALLOCATE( v(Nsize) )
    do i = 1,Nsize
      v(i) = 0.1d0 + i
    enddo 
  endif

  WRITE(*,*) 'MyModule is initialized'

END SUBROUTINE 


SUBROUTINE finalize_mymodule()
  USE MyModule
  IMPLICIT NONE
 
  DEALLOCATE( v )
  
  WRITE(*,*) 'MyModule is finalized'

END SUBROUTINE
