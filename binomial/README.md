
Overview
--------

`"binomial"` is a R package that provides several functions related to binomial distribution.

-   `bin_variable()` creates a binomial object (of class `"binvar"`).
-   `bin_probability()` calculates the probability of given success in given trials.
-   `bin_distribution()` gives you a distribution table for a `"binvar"` object.
-   `bin_cumulative()` gives you a cumulative distribution table for a `"binvar"` object.

Usage
-----

``` r
library(binomial)
# creating a binomial random variable 
bin <- bin_variable(trials = 5, prob = 0.5)
bin
#> Binomial Variable:
#> 
#> Parameters
#>  - number of trials: 5
#>  - prob of success : 0.5
# creating a binomial probability distribution
dis1 <- bin_distribution(trials = 5, prob = 0.5)
dis1
#>   success probability
#> 1       0     0.03125
#> 2       1     0.15625
#> 3       2     0.31250
#> 4       3     0.31250
#> 5       4     0.15625
#> 6       5     0.03125
# creating a binomial cumulative distribution
dis2 <- bin_cumulative(trials = 5, prob = 0.5)
dis2
#>   success probability cumulative
#> 1       0     0.03125    0.03125
#> 2       1     0.15625    0.18750
#> 3       2     0.31250    0.50000
#> 4       3     0.31250    0.81250
#> 5       4     0.15625    0.96875
#> 6       5     0.03125    1.00000
# summarizing the binomial variable with main statistical elements:
binsum <- summary(bin)
binsum
#> Binomial Variable:
#> 
#> Parameters
#> - number of trials: 5
#> - prob of success : 0.5
#> 
#> Measures
#> - mean    : 2.5
#> - variance: 1.25
#> - mode    : 3 2
#> - skewness: 0
#> - kurtosis: -0.4
```
