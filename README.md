
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
#>           a         b         c         d         e        f         g
#> 1 19.551885 27.354819  4.958851  6.616635 12.443115 17.16209 29.540747
#> 2 29.082288 28.363415 26.659768  5.597554  9.065899 28.18131  1.727452
#> 3  4.326445  4.296366 10.865787 20.671461 11.340321 26.76150  1.463381
#>            h        i         j
#> 1  0.1801603 26.35354 10.562400
#> 2 19.7719557 19.85644  2.510058
#> 3  8.1884533 21.14567 14.951008
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
(`p`):

``` r
(spai <- spai_3sfca(p, s, D))
#>       step3
#> a 1.0326488
#> b 1.4443051
#> c 0.5941029
#> d 0.9009222
#> e 0.7098114
#> f 1.1981005
#> g 2.4054461
#> h 0.4545690
#> i 1.4488551
#> j 0.8296435
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
