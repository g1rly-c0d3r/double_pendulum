program doublepen
  use diffeqsolver
  use diffeqfunc
  use plot
  use OMP_LIB
  implicit none

  ! parameters for pi and double precision floating-points
  integer, parameter  :: dp = kind(0.d0)
  real(dp), parameter :: pi = 3.1415926535897932384626433832795_dp

  ! path to the ffmpeg bin
  character(len=30), parameter :: FFMPEG = "/usr/bin/ffmpeg"

  ! number of equations in the system of diffeqs
  integer, parameter          :: m = 4
  ! number of steps to take 
  integer, parameter          :: N = 600
  real(dp), dimension(N)      :: t
  real(dp), dimension(N,m)    :: y
  real(dp), dimension(5)      :: init_cond
  real(dp)                    :: h, theta1, theta2, omega1, omega2, tnot, a, b
  real(dp), dimension(N)      :: x1, y1, x2, y2
  real(dp), dimension(4, N)   :: positions
  real(dp)                    :: l1, l2
  real(dp)                    :: start, finish
  integer                     :: time_file

  ! initial and final time point
  a = 0.0_dp
  b = 60.0_dp
  ! step size
  h = real(b - a, dp) / N
  
  tnot = 0.0_dp
  theta1 = 3*pi/4
  theta2 = pi/4
  omega1 = 0.0_dp
  omega2 = 0.0_dp
  l1 = 1.0_dp
  l2 = 1.0_dp

  init_cond = [theta1,theta2,omega1,omega2,tnot]

  ! time the actuall data
  CALL CPU_TIME(START)
  ! compute the diffeqs
  CALL sys_RK4(diffeq, init_cond, y, t, h, m)
  CALL CPU_TIME(FINISH)

  open(newunit=time_file, file="time_log")
  
  write(time_file, "('Data generation time: ', f0.6, ' seconds.')") finish-start

  ! turn the angles into cartesian coordinates
  x1 = l1 * cos(y(:,1) - pi/2)
  y1 = l1 * sin(y(:,1) - pi/2)

  x2 = x1 + l2 * cos(y(:,2) - pi/2) 
  y2 = y1 + l2 * sin(y(:,2) - pi/2)

  positions(1,:) = x1
  positions(2,:) = y1
  positions(3,:) = x2
  positions(4,:) = y2

  ! time how long it takes to make the video
  CALL CPU_TIME(START)
  ! plot the data and stich the video together
  CALL plot_vid(positions, N, FFMPEG, N/int(b-a))
  CALL CPU_TIME(FINISH)

  write(time_file, "('Video generation time: ', f0.6, ' seconds.')") finish-start

end program doublepen
