module diffeqfunc
  public diffeq

  contains 

function diffeq(t, y) result(yprime)
  integer, parameter   :: dp = kind(0.d0)
  real(dp), intent(in) :: t
  real(dp), intent(in) :: y
  real(dp)             :: yprime 

  yprime = t * (y + 5)
  
end function diffeq

end module
