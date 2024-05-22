program doublepen
  use diffeqsolver
  use diffeqfunc
  implicit none

  integer, parameter  :: dp = kind(0.d0)
  real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp

  integer, parameter          :: m = 4
  integer, parameter          :: N = 600
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(5)      :: init_cond
  real(dp)                    :: h, theta1, theta2, omega1, omega2, tnot, a, b
  real(dp), dimension(N)      :: x1, y1, x2, y2


  integer :: i

  a = 0.0_dp
  b = 60.0_dp
  h = real(b - a, dp) / N
  
  tnot = 0.0_dp
  theta1 = pi/4
  theta2 = 0.0_dp
  omega1 = 0.0_dp
  omega2 = 0.0_dp

  init_cond = [theta1,theta2,omega1,omega2,tnot]

  CALL sys_RK4(diffeq, init_cond, y, t, h, m)

  x1 = cos(y(:,1) - pi/2)
  y1 = sin(y(:,1) - pi/2)

  x2 = x1 + cos(y(:,2) - pi/2) 
  y2 = y1 + sin(y(:,2) - pi/2)


end program doublepen

