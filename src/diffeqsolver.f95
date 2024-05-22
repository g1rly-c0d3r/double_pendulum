module diffeqsolver
  use diffeqfunc
  implicit none

  private dp, euler, itterate
  public RK4, sys_RK4

  integer, parameter :: dp = kind(0.d0)
contains 

function itterate(dydt, t, Y_n, h, m) result(Y_n1)
  real(dp), intent(in)     :: t 
  real(dp), intent(in)     :: Y_n(:)
  real(dp)                 :: Y_n1(m)
  real(dp), dimension(4,m) :: k
  real(dp), intent(in)     :: h
  integer, intent(in)      :: m
  procedure(diffeq)        :: dydt

  k(1, :) = h * dydt(t, Y_n)

  k(2, :) = h * dydt( t + (h/2), Y_n + h*k(1, :)/2)

  k(3, :) = h * dydt(t + (h/2), Y_n + h*k(2, :) / 2)

  k(4, :) = h * dydt(t + h, Y_n + h*k(3, :))

  Y_n1 = Y_n + ((k(1, :) + 2*k(2,:) + 2*k(3,:) + k(4,:)) / 6)

end function
  

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




subroutine sys_RK4(dydt, init_cond, y, t, h, m)
  integer, intent(in)       :: m
  real(dp), intent(in)      :: init_cond(:)
  real(dp), intent(out)     :: y(:,:)
  real(dp), intent(out)     :: t(:)
  real(dp), dimension(4, m) :: k
  real(dp)                  :: h
  procedure(diffeq)         :: dydt
  integer                   :: i

  y(1,:) = itterate(dydt, init_cond(m), init_cond(1:m:1), h, m)
  t(1) = init_cond(m) + h

do i = 1, SIZE(y,1) - 1
  y(i+1, :) = itterate(dydt, t(i), y(i,:), h, m)
end do

  
end subroutine


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

