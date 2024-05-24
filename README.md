# Double Pendulum simulator written in ForTran

A (not so) simple double pendulum simulation software written in ForTran.

## goals: 

- Complete! ~~write a single-threaded simulator using gnuplot & ffmpeg to render the video~~
- implement ForTran-only rendering
- parallelize simulation compute & rendering using openMP
- implement GPU compute for simulation using openMP
- add cl options to customize how the simulation runs

## Dependencies:

- A ForTran compiler, can be specified in the Makefile, default is GForTran
- A Make implementation, I use GNU Make 

