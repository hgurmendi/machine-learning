#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

#include "random.h"


/* Allocates memory for a d-dimensional vector and returns it */
double *vector_new(int d)
{
    double *v;

    assert(d > 0);

    v = malloc(sizeof(double) * d);

    assert(v != NULL);

    return v;
}


/* Prints a d-dimensional vector to the standard output */
void vector_print(int d, double *v)
{
    int i;

    assert(d > 0);
    assert(v != NULL);

    for (i = 0; i < d; i++) {
        printf("%f ", v[i]);
    }
}


/* Fills a d-dimensional vector with a given value */
void vector_fill(int d, double *v, double value)
{
    int i;
    
    assert(d > 0);
    assert(v != NULL);

    for (i = 0; i < d; i++) {
        v[i] = value;
    }
}


/* Generates n normally distributed d-vectors with parameters mu and sigma
and a diagonal covariance matrix and writes them to a given file descriptor
with the C4.5 format */
void gen_class(int n, int d, double *mu, double sigma, int id, FILE *fd)
{
    int i, j;

    printf("Generating class %d with the following parameters:\n", id);
    printf("mu: ");
    vector_print(d, mu);
    printf("\nsigma: %f\n", sigma);

    for (i = 0; i < n; i++) {
        for (j = 0; j < d; j++) {
            fprintf(fd, "%f, ", random_norm(mu[j], sigma));
        }
        fprintf(fd, "%d\n", id);
    }

    printf("Class %d generation done\n", id);
}


int main(int argc, char *argv[])
{
    FILE *fd;
    double *mu;
    char *names_file, *data_file;
    int i, n, d;
    double C;

    if (argc <= 4) {
        printf("USAGE: %s <n> <d> <C> <output>\n", argv[0]);
        return 1;
    }

    n = atoi(argv[1]);
    d = atoi(argv[2]);
    C = atof(argv[3]);

    random_init();

    /* Generate filenames */
    asprintf(&names_file, "%s.names", argv[4]);
    asprintf(&data_file, "%s.data", argv[4]);

    printf("Names file: %s\n", names_file);
    printf("Data file: %s\n", data_file);

    /***********************/
    /* Generate names file */
    /***********************/
    fd = fopen(names_file, "w");
    assert(fd != NULL);
  
    fprintf(fd, "0, 1.\n\n");
    
    for (i = 0; i < d; i++) {
        fprintf(fd, "x%d: continuous.\n", i);
    }

    fclose(fd);

    /**********************/
    /* Generate data file */
    /**********************/
    fd = fopen(data_file, "w");
    assert(fd != NULL);

    mu = vector_new(d);
   
    /* CLASS 0 */
    vector_fill(d, mu, 0);
    mu[0] = -1.0;
    gen_class(n / 2, d, mu, C, 0, fd);

    /* CLASS 1 */
    vector_fill(d, mu, 0);
    mu[0] = 1.0;
    gen_class(n / 2, d, mu, C, 1, fd);
    
    fclose(fd);

    printf("Generation done\n");

    return 0;
}
