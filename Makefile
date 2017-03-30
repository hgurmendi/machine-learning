all:
	gcc -Wall -g -D_GNU_SOURCE -o ej_a ej_a.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o ej_b ej_b.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o ej_c ej_c.c -lm
	chmod +x plotter.R
	chmod +x examples.sh
