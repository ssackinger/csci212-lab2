all: fibonacci

fibonacci: fibonacci.o
	gcc -o $@ $+

fibonacci.o : fibonacci.s
	as -o $@ $<

clean:
	rm -vf fibonacci *.o
