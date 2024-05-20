module diffeqfunc
  public diffeq

  contains 

function diffeq(t, y) result(yprime)
  integer, parameter     :: dp = kind(0.d0)
  real(dp), intent(in)   :: t
  real(dp), intent(in)   :: y(:)
  real(dp), dimension(2) :: yprime 
  real(dp)               :: M, RHO, CD, R, A
  real(dp), parameter    :: pi = 3.1415926535897932384626433
  real(dp), parameter    :: g = 9.80665

  M = 160
  RHO = 1.25
  CD = 1.15 
  R = 3.9 
  A = pi*(R**2)

  yprime(1) = y(2)
  yprime(2) = ( (RHO * A * CD) / (2*M) * y(2)**2 ) - g
  
end function diffeq


end module
