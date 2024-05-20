program doublepen
  use diffeqsolver
  use diffeqfunc
  implicit none

  integer, parameter :: dp = kind(0.d0)

  integer, parameter          :: m = 2
  integer, parameter          :: N = 100000
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(3)      :: init_cond
  real(dp)                    :: h, ynot, vnot, tnot, a, b


  integer :: i

  a = 0.0_dp
  b = 8.0_dp
  h = real(b - a, dp) / N
  tnot = 0 
  ynot = 100
  vnot = 0

  init_cond = [ynot, vnot, tnot]

  CALL sys_RK4(diffeq, init_cond, y, t, h, m)

  print*, y(N,:)

end program doublepen

