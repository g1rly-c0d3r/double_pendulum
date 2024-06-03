F95 = gfortran
F95FLAGS = -O3 -march=native -Isrc/ -I"${HOME}/.local/include" -Jtarget/
UNIXMODPATH=~/.local/include/libfortran-unix/unix.mod

target/%.o: src/%.f95
	${F95} ${F95FLAGS} -c -o $@ $^ -lfortran-unix -fopenmp

OBJS = target/function.o target/diffeqsolver.o target/main.o

all: $(OBJS) 
	${F95} ${F95FLAGS} -o target/double_pendulum $^ -lfortran-unix -fopenmp

debug:
	${F95} -g -Jtarget/ -o target/debug src/function.f95 src/diffeqsolver.f95 src/main.f95 -lfortran-unix -fopenmp
	gdb target/debug

run: clean all 
	./target/double_pendulum

clean:
	rm -f double_pendulum.mp4
	rm -rf target
	mkdir -p target/data
	cp ${UNIXMODPATH} target/
