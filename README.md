# Double Pendulum simulator written in ForTran

A (not so) simple double pendulum simulation software written in ForTran.

## goals: 

- Complete! ~~write a single-threaded simulator using gnuplot & ffmpeg to render the video~~
- Complete! ~~implement ForTran-only rendering (no shell script, forking gnuplot & ffmpeg processes directly from the ```double_pendulum``` bin)~~
- I didn't actually need that one ~~parallelize simulation compute & rendering using openMP~~
- implement GPU compute for simulation using openMP

## Dependencies:

- A ForTran compiler, can be specified in the Makefile, default is GForTran
- A Make implementation, I use GNU Make 
- ffmpeg, a command-line video utility, used for compiling each frame

- [Fortran-unix](https://github.com/interkosmos/fortran-unix), a library to access posix pipes to fork the ffmpeg proccess to generate the video.
- [PLPlot](www.plplot.org), a plotting library written in C to plot the data
