#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

/* Generates an uniformly distributed random number in [0, 1] */
#define random() (rand() / ((double) RAND_MAX))

/* Generates an uniformly distributed random number in [start, end] */
#define randomr(start, end) ((start) + (random() * ((end) - (start))))

/* Allocates memory for a d-dimensional vector and returns it */
double *vector_new(int d)
{
    double *v;

    assert(d > 0);

    v = malloc(sizeof(double) * d);

    assert(v != NULL);

    return v;
}

/* Prints a d-dimensional vector to the standard input */
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

/* Probability Density Function for a normal distribution with parameters mu and sigma */
double norm(double mu, double sigma, double x)
{
    return (1.0 / (sqrt(2 * M_PI) * sigma)) * exp(-(((x - mu) * (x - mu)) / (2 * sigma * sigma)));
}

/* Generates a normally distributed number with parameters mu and sigma */
double genNorm(double mu, double sigma)
{
    double left, right, max, x, y;

    left = mu - 5.0 * sigma;
    right = mu + 5.0 * sigma;
    max = 1.0 / sqrt(2 * M_PI) * sigma;

    do {
        x = randomr(left, right);
        y = randomr(0, max);
    } while (y > norm(mu, sigma, x));

    return x;
}

/* Generates n normally distributed d-vectors with parameters mu and sigma and a diagonal
covariance matrix and writes them to a given file descriptor with the C4.5 format */
void genClass(int n, int d, double *mu, double sigma, char id, FILE *fd)
{
    int i, j;

    printf("Generating class %c with the following parameters:\n", id);
    printf("mu: ");
    vector_print(d, mu);
    printf("\nsigma: %f\n", sigma);

    for (i = 0; i < n; i++) {
        for (j = 0; j < d; j++) {
            fprintf(fd, "%f, ", genNorm(mu[j], sigma));
        }
        fprintf(fd, "%c\n", id);
    }

    printf("Class %c generation done\n", id);
}

int main(int argc, char *argv[])
{
    FILE *fd;
    double *mu;
    char *namesFile, *dataFile;
    int i, n, d;
    double C;

    if (argc <= 4) {
        printf("USAGE: %s <n> <d> <C> <output>\n", argv[0]);
        return 1;
    }

    n = atoi(argv[1]);
    d = atoi(argv[2]);
    C = atof(argv[3]);

    srand(time(NULL));

    /* Generate filenames */
    asprintf(&namesFile, "%s.names", argv[4]);
    asprintf(&dataFile, "%s.data", argv[4]);

    printf("Names file: %s\n", namesFile);
    printf("Data file: %s\n", dataFile);

    /***********************/
    /* Generate names file */
    /***********************/
    fd = fopen(namesFile, "w");
    assert(fd != NULL);
  
    fprintf(fd, "0, 1.\n\n");
    
    for (i = 0; i < d; i++) {
        fprintf(fd, "x%d: continuous.\n", i);
    }

    fclose(fd);

    /**********************/
    /* Generate data file */
    /**********************/
    fd = fopen(dataFile, "w");
    assert(fd != NULL);

    mu = vector_new(d);
   
    /* CLASS 0 */
    vector_fill(d, mu, -1.0);
    genClass(n / 2, d, mu, C * sqrt(d), '0', fd);

    /* CLASS 1 */
    vector_fill(d, mu, 1.0);
    genClass(n / 2, d, mu, C * sqrt(d), '1', fd);
    
    fclose(fd);

    printf("Generation done\n");

    return 0;
}
