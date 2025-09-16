PLPLOTMODPATH=/usr/lib/fortran/modules/plplot
F95 = gfortran
F95FLAGS = -O2 -march=native -Isrc/ -I"${HOME}/.local/include" -I${PLPLOTMODPATH} -Jtarget/ -L ~/.local/lib/

target/%.o: src/%.f95
	${F95} ${F95FLAGS} -c -o $@ $^ -lfortran-unix -lplplotfortran -fopenmp

OBJS = target/function.o target/diffeqsolver.o target/plot.o target/main.o

all: $(OBJS) 
	${F95} -I${PLPLOTMODPATH} -o target/double_pendulum $^ -lplplotfortran -fopenmp
	 

debug:
	${F95} -g -Jtarget/ -I${HOME}/.local/include -I${PLPLOTMODPATH} -o target/debug src/function.f95 src/diffeqsolver.f95 src/plot.f95 src/main.f95 -lplplotfortran
	gdb target/debug

run: all 
	rm -f target/data/*
	./target/double_pendulum -dev pngcairo


.PHONY:clean
clean:
	rm -f double_pendulum.mp4 ./time_log
	rm -rf target
	mkdir -p target/data
