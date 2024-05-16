F95 = gfortran
F95FLAGS = -O3 -march=native -Isrc/ -Jtarget/

target/%.o: src/%.f95
	${F95} ${F95FLAGS} -c -o $@ $^

OBJS = target/diffeqsolver.o target/function.o target/main.o

all: $(OBJS)
	${F95} ${F95FLAGS} -o target/double_pendulum $^

target: 
	@mkdir target
run: all
	./target/double_pendulum

clean:
	rm -f target/*
