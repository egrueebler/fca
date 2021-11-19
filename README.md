
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
#>          a        b         c         d        e          f        g         h
#> 1 25.74653  9.71532 27.971117 10.631694 26.55025  6.7708967 24.73130 27.660026
#> 2 29.30724 19.71373  9.100438  1.557964 26.08831  0.4669214  4.59481 26.843519
#> 3 11.17288 19.80053 12.981120 18.323015 15.66079 22.6998866 26.11951  4.775688
#>          i         j
#> 1 29.87636 26.909644
#> 2 23.84058  1.085789
#> 3 12.18657 22.582598
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
(spai <- spai_3sfca(p, s, W))
#>       step3
#> a 0.8409322
#> b 3.9524345
#> c 0.2197445
#> d 0.9487611
#> e 0.2082522
#> f 2.9145447
#> g 0.2269095
#> h 2.7267004
#> i 0.6365243
#> j 0.2850320
```

## References

-   [Grüebler E. (2021). Geospatial Analysis of Access to Healthcare:
    Child Development Needs and Available Care in the Canton of
    Zurich.](https://lean-gate.geo.uzh.ch/prod/typo3conf/ext/qfq/Classes/Api/download.php/mastersThesis/833)
-   [Bauer, J., & Groneberg, D. A. (2016). Measuring Spatial
    Accessibility of Health Care Providers – Introduction of a Variable
    Distance Decay Function within the Floating Catchment Area (FCA)
    Method.](https://doi.org/10.1371/journal.pone.0159148)
-   [Joerg, R., Lenz, N., Wetz, S., & Widmer, M. (2019). Ein Modell zur
    Analyse der Versorgungsdichte. Herleitung eines Index zur räumlichen
    Zugänglichkeit mithilfe von GIS und Fallstudie zur ambulanten
    Grundversorgung in der
    Schweiz.](https://www.obsan.admin.ch/de/publikationen/ein-modell-zur-analyse-der-versorgungsdichte)
