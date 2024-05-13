module diffeqsolver
  implicit none

  private dp, euler
  public RK4 

  integer, parameter :: dp = kind(0.d0)
contains 

subroutine RK4(dydt, init_cond, y, t, h)
  real(dp), intent(in)   :: init_cond(:)
  real(dp), intent(out)  :: y(:)
  real(dp), intent(out)  :: t(:)
  real(dp), dimension(4) :: k
  real(dp)               :: h
  real(dp)               :: dydt
  integer                :: i 

  y(1) = init_cond(1) + dydt(init_cond(3), init_cond(2))
  t(1) = init_cond(3) + h

do i = 1, SIZE(y) - 1   
  k(1) = dydt(t(i), y(i)) 

  k(2) = dydt(t(i), y(i) + h*k(1) / 2)

  k(3) = dydt(t(i), y(i) + h*k(2) / 2)

  k(4) = dydt(t(i), y(i) + h*k(3))

  y(i+1) = y(i) + (h/6) * (k(1) + 2*k(2) + 2*k(3) + k(4))

  t(i+1) = t(i) + h
end do

  
end subroutine RK4

subroutine euler(dydt, init_cond, y, h, n)
  real(dp)              :: dydt
  real(dp), intent(in)  :: init_cond(:)
  real(dp), intent(in)  :: h 
  real(dp), intent(out) :: y(:)
  integer, intent(in)   :: n
  integer               :: i
  
  y(1) = init_cond(1) + dydt(init_cond(2))

if (SIZE(y).lt.2) then
  return
end if

  
do i = 2, n
  y(i) = y(i-1) + h * dydt(y(i-1))
end do

end subroutine euler
    
end module diffeqsolver

