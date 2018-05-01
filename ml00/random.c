#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>
#include <assert.h>


/* Type for the PRNG seed */
#define SEED_TYPE long int


/* Size in bytes of the PRNG seed */
#define SEED_SIZE sizeof(SEED_TYPE)


/* Initiates the PRNG seed using the clock with nanosecond presicion. */
void random_init()
{
/*
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    srand48((SEED_TYPE) ts.tv_nsec * ts.tv_sec);
*/
    FILE *fd;
    int ret;
    SEED_TYPE seed;

    fd = fopen("/dev/urandom", "r");
    assert(fd != NULL);

    ret = fread(&seed, 1, SEED_SIZE, fd);
    assert(ret != -1);

    ret = fclose(fd);
    assert(ret != -1);

    srand48(seed);
}


/* Generates a uniformly distributed random number in the interval
[left, right) */
double random_uniform(double left, double right)
{
    return left + (right - left) * drand48();
}


/* Probability Density Function for a normal distribution with parameters mu
and sigma */
double norm(double mu, double sigma, double x)
{
    return (1.0 / (sqrt(2 * M_PI) * sigma)) * exp(-(((x - mu) * (x - mu)) / (2 * sigma * sigma)));
}


/* Generates a normally distributed number with parameters mu and sigma */
double random_norm(double mu, double sigma)
{
    double left, right, max, x, y;

    left = mu - 5.0 * sigma;
    right = mu + 5.0 * sigma;
    max = norm(mu, sigma, mu);

    do {
        x = random_uniform(left, right);
        y = random_uniform(0, max);
    } while (y > norm(mu, sigma, x));

    return x;
}

