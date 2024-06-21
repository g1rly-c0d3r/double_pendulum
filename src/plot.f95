module plot
  use unix
  use plplot
implicit none

private dp
  integer, parameter  :: dp = kind(0.d0)
public plot_vid

contains 

  subroutine plot_vid(positions, N, FFMPEG, framerate_num)
    real(dp), intent(inout)          :: positions(:, :)
    character(len=30), intent(in)    :: FFMPEG
    integer, intent(in)              :: framerate_num
    integer, intent(in)              :: N

    integer                          :: rc, i, j
    type(c_ptr)                      :: ffmpg_ptr
    character(len=100)               :: filename
    character(len=DIGITS(N)-4)       :: filenum
    character(len=20)                :: framerate


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
      
      call pljoin(0._dp, 0._dp, positions(1, i), positions(2,i))
      call pljoin(positions(1, i), positions(2,i), positions(3, i), positions(4, i))
      call plstring([positions(1,i), positions(3,i)], [positions(2,i), positions(4,i)], '*')
    
      call plend()
    end do

    write(framerate, "(I20)") framerate_num
    
    ffmpg_ptr = c_popen(TRIM(TRIM(FFMPEG)//" -y -framerate "//TRIM(ADJUSTL(framerate))&
      //" -pattern_type glob -i 'target/data/*.png' -c:v libx264 -r 200 -f mp4 double_pendulum.mp4;"), "w")
    
    rc = c_pclose(ffmpg_ptr)

  end subroutine plot_vid

end module 
