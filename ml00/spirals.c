#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

#include "random.h"


/* Generation radius */
#define RADIUS 1.00


/* Parameter for the spiral's equation */
#define SPIRAL_PARAM (1 / (4 * M_PI))


/* Determines the radios of a spiral with parameters a and b for a given
theta */
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


int get_class(double x, double y)
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
    char *names_file, *data_file;
    double x, y;

    if (argc <= 2) {
        printf("USAGE: %s <n> <output>\n", argv[0]);
        return 1;
    }
    
    n = atoi(argv[1]);

    random_init();

    /* Generate filenames */
    asprintf(&names_file, "%s.names", argv[2]);
    asprintf(&data_file, "%s.data", argv[2]);

    printf("Names file: %s\n", names_file);
    printf("Data file: %s\n", data_file);

    /***********************/
    /* Generate names file */
    /***********************/
    fd = fopen(names_file, "w");
    assert(fd != NULL);
  
    fprintf(fd, "0, 1.\n\n");
    
    fprintf(fd, "x: continuous.\n");
    fprintf(fd, "y: continuous.\n");

    fclose(fd);

    /**********************/
    /* Generate data file */
    /**********************/
    fd = fopen(data_file, "w");
    assert(fd != NULL);

    gen[0] = n / 2;
    gen[1] = n - (n / 2);

    while (gen[0] > 0 || gen[1] > 0) {
        do {
            x = random_uniform(-RADIUS, RADIUS);
            y = random_uniform(-RADIUS, RADIUS);
        } while (sqrt(x * x + y * y) > RADIUS);

        class = get_class(x, y);

        if (gen[class] > 0) {
            gen[class]--;
            fprintf(fd, "%f, %f, %d\n", x, y, class);
        }
    }
    
    fclose(fd);

    return 0;
}
