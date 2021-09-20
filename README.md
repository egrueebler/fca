
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Floating Catchment Area (FCA) Methods

<!-- badges: start -->

[![R-CMD-check](https://github.com/egrueebler/fca/workflows/R-CMD-check/badge.svg)](https://github.com/egrueebler/fca/actions)
[![Codecov test
coverage](https://codecov.io/gh/egrueebler/fca/branch/main/graph/badge.svg)](https://app.codecov.io/gh/egrueebler/fca/branch/main)
<!-- badges: end -->

Floating Catchment Area (FCA) methods to Calculate Spatial
Accessibility.

Perform various floating catchment area methods to calculate a spatial
accessibility index (SPAI) for demand point data. The distance matrix
used for weighting is normalized in a preprocessing step using common
functions (gaussian, gravity, exponential or logistic).

## Installation

You can install the released version of fca from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("fca")
```

And the development version from
[GitHub](https://github.com/egrueebler/fca) with:

``` r
# install.packages("devtools")
devtools::install_github("egrueebler/fca")
```

## Example

This is a basic example which shows you how to calculate a SPAI for
demand point data using FCA methods.

Create an example population, supply and distances:

``` r
# Population df with column for size
pop <- data.frame(
  orig_id = letters[1:10],
  size = c(100, 200, 50, 100, 500, 50, 100, 100, 50, 500)
)

# Supply df with column for capacity
sup <- data.frame(
  dest_id = as.character(1:3),
  capacity = c(1000, 200, 500)
)

# Distance matrix with travel times from 0 to 30
D <- matrix(
  runif(30, min = 0, max = 30),
  ncol = 10, nrow = 3, byrow = TRUE,
  dimnames = list(c(1:3), c(letters[1:10]))
)
D
#>           a        b         c        d         e        f        g        h
#> 1  1.676809 10.35507 25.855560 29.81445  2.706818 19.31611 22.59863 22.22735
#> 2 16.413526 18.46545  4.777401 14.69600  5.582302 10.51129 24.36357 13.90182
#> 3  1.896348 21.75346 28.254288 21.13959 22.342897 24.97748 29.88072 21.19801
#>           i         j
#> 1 25.593141  3.513775
#> 2  8.933946 20.928989
#> 3  8.910488 11.077071
```

Normalize distance matrix with gaussian function, apply a threshold of
20 minutes (to compute beta for the function) and formatting input data
as named vectors for the FCA method (match IDs of distance weight matrix
with demand and supply data).

``` r
library(fca)

# Normalize distances
W <- dist_normalize(
  D,
  d_max = 20,
  imp_function = "gaussian", function_d_max = 0.01
)

# Ensure order of ids
pop <- pop[order(pop$orig_id), ]
sup <- sup[order(sup$dest_id), ]

# Named vectors
(p <- setNames(pop$size, as.character(pop$orig_id)))
#>   a   b   c   d   e   f   g   h   i   j 
#> 100 200  50 100 500  50 100 100  50 500
(s <- setNames(sup$capacity, as.character(sup$dest_id)))
#>    1    2    3 
#> 1000  200  500
```

Apply FCA method on formatted input, get SPAI for each origin location
(p):

``` r
(spai <- spai_3sfca(p, s, D))
#>       step3
#> a 0.2769918
#> b 0.8217861
#> c 2.5905041
#> d 2.8434273
#> e 0.5818357
#> f 1.6893142
#> g 1.7696781
#> h 1.9444476
#> i 2.9506756
#> j 0.3994915
```

## References

-   [Bauer, J., & Groneberg, D. A. (2016). Measuring Spatial
    Accessibility of Health Care Providers – Introduction of a Variable
    Distance Decay Function within the Floating Catchment Area (FCA)
    Method.](https://doi.org/10.1371/journal.pone.0159148)
-   [Joerg, R., Lenz, N., Wetz, S., & Widmer, M. (2019). Ein Modell zur
    Analyse der Versorgungsdichte. Herleitung eines Index zur räumlichen
    Zugänglichkeit mithilfe von GIS und Fallstudie zur ambulanten
    Grundversorgung in der
    Schweiz.](https://www.obsan.admin.ch/de/publikationen/ein-modell-zur-analyse-der-versorgungsdichte)
