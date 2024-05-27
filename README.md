# Double Pendulum simulator written in ForTran

A (not so) simple double pendulum simulation software written in ForTran.

## goals: 

- Complete! ~~write a single-threaded simulator using gnuplot & ffmpeg to render the video~~
- implement ForTran-only rendering (no shell script, forking gnuplot & ffmpeg processes)
- parallelize simulation compute & rendering using openMP
- implement GPU compute for simulation using openMP
- add cl options to customize how the simulation runs

## Dependencies:

- A ForTran compiler, can be specified in the Makefile, default is GForTran
- A Make implementation, I use GNU Make 
- ffmpeg, a command-line video utility, used for compiling each frame
- gnuplot, a command-line plotting utility, used to generate an image of each time step of the simulation

- [Fortran-unix](https://github.com/interkosmos/fortran-unix), a library to access posix pipes to fork gnuplot & ffmpeg proccesses to generate the video.