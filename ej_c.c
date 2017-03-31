#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

/* Generates an uniformly distributed random number in [0, 1] */
#define random() (rand() / ((double) RAND_MAX))

/* Generates an uniformly distributed random number in [start, end] */
#define randomr(start, end) ((start) + (random() * ((end) - (start))))

/* Generation radius */
#define RADIUS 1.00

/* Parameter for the spiral's equation */
#define SPIRAL_PARAM (1 / (4 * M_PI))

/* Determines the radios of a spiral with parameters a and b for a given theta */
double spiral(double a, double b, double theta)
{
    return a + b * theta;
}

/* Determines the radius and theta of a given cartesian coordinate */
void cart2polar(double x, double y, double *r, double *theta)
{
    *r = sqrt(x * x + y * y);

    *theta = atan2(y, x);
}

int getClass(double x, double y)
{
    double r0, theta0, inner, outer, sep;

    cart2polar(x, y, &r0, &theta0);
    
    /* Compute radius for both spirals and separation between them */
    inner = spiral(0, SPIRAL_PARAM, theta0);
    outer = spiral(0.25, SPIRAL_PARAM, theta0);
    sep = 2 * M_PI * SPIRAL_PARAM;

    while (inner <= RADIUS) {
        if (r0 >= inner && r0 <= outer) {
            return 0;
        }

        inner += sep;
        outer += sep;
    }

    return 1;
}

int main(int argc, char *argv[])
{
    FILE *fd;
    int n, gen[2], class;
    char *namesFile, *dataFile;
    double x, y;

    if (argc <= 2) {
        printf("USAGE: %s <n> <output>\n", argv[0]);
        return 1;
    }
    
    n = atoi(argv[1]);

    srand(time(NULL));
    
    /* Generate filenames */
    asprintf(&namesFile, "%s.names", argv[2]);
    asprintf(&dataFile, "%s.data", argv[2]);

    printf("Names file: %s\n", namesFile);
    printf("Data file: %s\n", dataFile);

    /***********************/
    /* Generate names file */
    /***********************/
    fd = fopen(namesFile, "w");
    assert(fd != NULL);
  
    fprintf(fd, "0, 1.\n\n");
    
    fprintf(fd, "x: continuous.\n");
    fprintf(fd, "y: continuous.\n");

    fclose(fd);

    /**********************/
    /* Generate data file */
    /**********************/
    fd = fopen(dataFile, "w");
    assert(fd != NULL);

    gen[0] = gen[1] = n / 2;

    while (gen[0] > 0 || gen[1] > 0) {
        do {
            x = randomr(-RADIUS, RADIUS);
            y = randomr(-RADIUS, RADIUS);
        } while (sqrt(x * x + y * y) > RADIUS);

        class = getClass(x, y);

        if (gen[class] > 0) {
            gen[class]--;
            fprintf(fd, "%f, %f, %d\n", x, y, class);
        }
    }
    
    fclose(fd);

    return 0;
}
