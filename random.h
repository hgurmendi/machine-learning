#ifndef __RANDOM_H__
#define __RANDOM_H__

/* Initiates the PRNG seed using the clock with nanosecond presicion. */
void random_init();


/* Generates a uniformly distributed random number in the interval
[left, right) */
double random_uniform(double left, double right);


/* Probability Density Function for a normal distribution with parameters mu
and sigma */
double norm(double mu, double sigma, double x);


/* Generates a normally distributed number with parameters mu and sigma */
double random_norm(double mu, double sigma);


#endif
