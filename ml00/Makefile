all:
	gcc -Wall -g -D_GNU_SOURCE -o diagonal random.c diagonal.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o parallel random.c parallel.c -lm
	gcc -Wall -g -D_GNU_SOURCE -o spirals random.c spirals.c -lm
	chmod +x plotter.R
	chmod +x examples.sh

clean:
	rm -f diagonal parallel spirals
