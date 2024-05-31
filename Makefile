F95 = gfortran
F95FLAGS = -O3 -march=native -Isrc/ -Jtarget/

target/%.o: src/%.f95
	${F95} ${F95FLAGS} -c -o $@ $^

OBJS = target/function.o target/diffeqsolver.o target/main.o

all: $(OBJS) 
	${F95} ${F95FLAGS} -o target/double_pendulum $^ -lfortran-unix

debug:
	${F95} -g -o target/debug src/function.f95 src/diffeqsolver.f95 src/main.f95 
	gdb target/debug

run: all
	rm -f target/data/*
	./target/double_pendulum
	bash src/gen_vid.bash

clean:
	rm -rf target
	mkdir -p target/data
