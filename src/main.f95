program doublepen
  use diffeqsolver
  use diffeqfunc
  use unix
  implicit none

  integer, parameter  :: dp = kind(0.d0)
  real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp

  character(len=20), parameter :: GNUPLOT = "/usr/bin/gnuplot"
  integer                      :: rc
  type(c_ptr)                  :: gnp_ptr


  integer, parameter          :: m = 4
  integer, parameter          :: N = 6000
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(5)      :: init_cond
  real(dp)                    :: h, theta1, theta2, omega1, omega2, tnot, a, b
  real(dp), dimension(N)      :: x1, y1, x2, y2
  real(dp)                    :: l1, l2

  integer                     :: fstream
  character(len=100)          :: filename
  character(len=DIGITS(N)-4)  :: filenum

  integer :: i, j

  a = 0.0_dp
  b = 60.0_dp
  h = real(b - a, dp) / N
  
  tnot = 0.0_dp
  theta1 = 0.0_dp
  theta2 = 0.0_dp
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
  do j = 1, DIGITS(N) - 4 
    filenum(DIGITS(N) -3 - j : DIGITS(N) -3 - j) = char(mod(i/10**(j-1), 10) + 48)
  end do

  filename = "target/data/pos_"//filenum//".dat"
  open(newunit=fstream, file=filename, status="replace", action="write")

  write(fstream, *) 0, 0
  write(fstream, *) x1(i), y1(i)
  write(fstream, *) x2(i), y2(i)
  close(fstream)

  gnp_ptr = c_popen(GNUPLOT//"-e 'set term png; &
                                  set output """//trim(filename)//".png"";&
                                  set grid;&
                                  set xrange[-2:2];&
                                  set yrange[-2:2];&
                                  plot """//trim(filename)//""" w linespoints lt 7;'", "w")
  rc = c_pclose(gnp_ptr)
end do



end program doublepen

