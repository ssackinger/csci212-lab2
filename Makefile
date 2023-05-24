all: fibonacci gcd

fibonacci: fibonacci.o
	gcc -o $@ $+

fibonacci.o : fibonacci.s
	as -o $@ $<

gcd: gcd.o
	gcc -o $@ $+

gcd.o : gcd.s
	as -o $@ $<

clean:
	rm -vf fibonacci gcd *.o
