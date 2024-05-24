program doublepen
  use diffeqsolver
  use diffeqfunc
  implicit none

  integer, parameter  :: dp = kind(0.d0)
  real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp

  integer, parameter          :: m = 4
  integer, parameter          :: N = 9999
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(5)      :: init_cond
  real(dp)                    :: h, theta1, theta2, omega1, omega2, tnot, a, b
  real(dp), dimension(N)      :: x1, y1, x2, y2
  real(dp)                    :: l1, l2

  integer                     :: fstream
  character(len=100)          :: filename
  character(len=4)            :: filenum


  integer :: i, j

  a = 0.0_dp
  b = 60.0_dp
  h = real(b - a, dp) / N
  
  tnot = 0.0_dp
  theta1 = 1e-12_dp
  theta2 = 0.1_dp
  omega1 = 0.0_dp
  omega2 = 0.0_dp
  l1 = 1.0_dp
  l2 = 1.0_dp

  init_cond = [theta1,theta2,omega1,omega2,tnot]

  CALL sys_RK4(diffeq, init_cond, y, t, h, m)

  x1 = l1 * cos(y(:,1) - pi/2)
  y1 = l1 * sin(y(:,1) - pi/2)

  x2 = x1 + l2 * cos(y(:,2) - pi/2) 
  y2 = y1 + l2 * sin(y(:,2) - pi/2)

do i = 1, N
  filenum = char(mod(i/1000, 10) + 48)//char(mod(i/100, 10) + 48)//char(mod(i/10, 10) + 48)//char(mod(i, 10) + 48)
  filename = "target/data/pos_"// filenum //".dat"
  open(newunit=fstream, file=filename, status="replace", action="write")

  write(fstream, *) 0, 0
  write(fstream, *) x1(i), y1(i)
  write(fstream, *) x2(i), y2(i)
  close(fstream)
end do



end program doublepen

