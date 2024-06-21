F95 = gfortran
F95FLAGS = -O2 -march=native -Isrc/ -I"${HOME}/.local/include" -Jtarget/
PLPLOTMODPATH=~/.local/lib/fortran/modules/plplot/

target/%.o: src/%.f95
	${F95} ${F95FLAGS} -c -o $@ $^ -lfortran-unix -lplplotfortran -fopenmp

OBJS = target/function.o target/diffeqsolver.o target/plot.o target/main.o

all: $(OBJS) 
	${F95} ${F95FLAGS} -I${PLPLOTMODPATH} -o target/double_pendulum $^ -lfortran-unix -lplplotfortran -fopenmp

debug:
	${F95} -g -Jtarget/ -o target/debug src/function.f95 src/diffeqsolver.f95 src/main.f95 -lfortran-unix -lplplotfortran
	gdb target/debug

run: all 
	rm -f target/data/*
	./target/double_pendulum -dev pngcairo


clean:
	rm -f double_pendulum.mp4
	rm -rf target
	mkdir -p target/data
	cp ${PLPLOTMODPATH}plplot.mod target/
