program doublepen
  use diffeqsolver
  use diffeqfunc
  implicit none

  integer, parameter :: dp = kind(0.d0)

  real(dp), dimension(1000) :: y, t
  real(dp), dimension(3)  :: init_cond
  real(dp)                :: h 

  integer :: i

  h = 0.001
  init_cond = [-4., 0., 0.]

  CALL RK4(diffeq, init_cond, y, t, h)

do i = 1, 1000
  print*,  y(i)
end do

  

end program doublepen

