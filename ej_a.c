#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>
#include <time.h>

/* Generates a random number in [0, 1] */
#define random() (rand() / ((double) RAND_MAX))

/* Vector dimension */
int d = 0;

double *vector_new()
{
    double *v;

    assert(d > 0);

    v = malloc(sizeof(double) * d);

    assert(v != NULL);

    return v;
}

void vector_print(double *v)
{
    int i;

    assert(d > 0);
    assert(v != NULL);

    for (i = 0; i < d; i++) {
        printf("%f ", v[i]);
    }

    printf("\n");
}

void vector_fill(double *v, double value)
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
    double left, right, delta, max, x, y;

    left = mu - 5.0 * sigma;
    right = mu + 5.0 * sigma;
    delta = right - left;
    max = 1.0 / sqrt(2 * M_PI) * sigma;

    do {
        x = left + random() * delta;
        y = random() * max;
    } while (y > norm(mu, sigma, x));

    return x;
}

/* Generates n normally distributed d-vectors with parameters mu and sigma and a diagonal
covariance matrix and writes them to a given file descriptor with the C4.5 format */
void genClass(int n, double *mu, double sigma, char id, FILE *fd)
{
    int i, j;

    for (i = 0; i < n; i++) {
        for (j = 0; j < d; j++) {
            fprintf(fd, "%f, ", genNorm(mu[j], sigma));
        }
        fprintf(fd, "%c\n", id);
    }
}

int main(int argc, char *argv[])
{
    FILE *fd;
    double *mu;
    char *namesFile, *dataFile;
    int i, j, n;
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

    /* Show generation parameters */
    printf("Parameters:\n");
    printf("n: %d\n", n);
    printf("d: %d\n", d);
    printf("C: %f\n", C);
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

    mu = vector_new();
   
    /* CLASS 0 */
    vector_fill(mu, -1.0);    
    genClass(n / 2, mu, C * sqrt(d), '0', fd);

    /* CLASS 1 */
    vector_fill(mu, 1.0);
    genClass(n / 2, mu, C * sqrt(d), '1', fd);
    
    fclose(fd);

    return 0;
}
