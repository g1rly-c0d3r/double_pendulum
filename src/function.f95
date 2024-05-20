module diffeqfunc
  public diffeq

  contains 

function diffeq(t, y) result(yprime)
  integer, parameter     :: dp = kind(0.d0)
  real(dp), intent(in)   :: t
  real(dp), intent(in)   :: y(:)
  real(dp), dimension(4) :: yprime 
  real(dp), parameter    :: m1 = 1 !kg
  real(dp), parameter    :: m2 = 1 !kg
  real(dp), parameter    :: l1 = 1 !m
  real(dp), parameter    :: l2 = 1 !m
  real(dp), parameter    :: g = 9.80665 !m/s**2

  yprime(1) = y(3)
  yprime(2) = y(4)
  yprime(3) =     / &
              
  yprime(4) =     / &
              
  
end function diffeq


end module
