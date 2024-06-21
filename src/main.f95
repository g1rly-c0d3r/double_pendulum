program doublepen
  use diffeqsolver
  use diffeqfunc
  use unix
  use plplot
  use OMP_LIB
  implicit none

  integer, parameter  :: dp = kind(0.d0)
  real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp

  character(len=30), parameter :: FFMPEG = "/usr/bin/ffmpeg -y"
  integer                      :: rc
  type(c_ptr)                  :: gnp_ptr
  type(c_ptr)                  :: ffmpg_ptr


  integer, parameter          :: m = 4
  integer, parameter          :: N = 3000
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(5)      :: init_cond
  real(dp)                    :: h, theta1, theta2, omega1, omega2, tnot, a, b
  real(dp), dimension(N)      :: x1, y1, x2, y2
  real(dp)                    :: l1, l2

  integer                     :: fstream
  character(len=100)          :: filename
  character(len=DIGITS(N)-4)  :: filenum
  character(len=20)           :: framerate

  integer :: i, j

  a = 0.0_dp
  b = 60.0_dp
  h = real(b - a, dp) / N
  
  tnot = 0.0_dp
  theta1 = 3*pi/4
  theta2 = pi/4
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
  do j = 1, DIGITS(N)-4
    filenum(DIGITS(N) - 3 - j:DIGITS(N) - 3 - j) = char(mod(i/10**(j-1),10) +48)
  end do
  filename = "target/data/pos_"//TRIM(ADJUSTL(filenum))//".png"
  rc = plparseopts(PL_PARSE_FULL)
  rc = plsetopt('o', TRIM(filename))
  call plinit()
  call plcol0(15)
  
  call plenv(-2., 2., -2., 2., 0, 0)
  call pllab('','',filename)
  
  call pljoin(0._dp, 0._dp, x1(i), y1(i))
  call pljoin(x1(i), y1(i), x2(i), y2(i))
  call plstring([x1(i), x2(i)], [y1(i), y2(i)], '*')

  call plend()
end do
  

write(framerate, "(I20)") N / int(b-a)

ffmpg_ptr = c_popen(TRIM(TRIM(FFMPEG)//" -framerate "//TRIM(ADJUSTL(framerate))&
  //" -pattern_type glob -i 'target/data/*.png' -c:v libx264 -r 200 -f mp4 double_pendulum.mp4;"), "w")

rc = c_pclose(ffmpg_ptr)


end program doublepen
