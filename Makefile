all:
	gcc -Wall -g -D_GNU_SOURCE -o ej_a random.c ej_a.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o ej_b random.c ej_b.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o ej_c random.c ej_c.c -lm
	chmod +x plotter.R
	chmod +x examples.sh

clean:
	rm -f ej_a ej_b ej_c
