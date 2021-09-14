#' Distance weights methods
#'
#' @param D matrix, distance or time values
#' @param d0 numeric, threshold for max distance
#' @param functiond0 numeric, result for function(d0)
#' @param impFunction character, type of distance weights method
#'
#' @return matrix, normalized distance or time values
#' @export
#'
#' @examples
#' get_distance_weights(matrix(10), 10, "gaussian")
get_distance_weights <- function(D, d0, impFunction, functiond0 = 0.01) {
  if (impFunction == "gaussian") {
    D[is.na(D)] <- 0
    b <- -(d0^2) / (log(functiond0))
    D <- exp(-D^2 / b)
  } else if (impFunction == "gravity") {
    D[is.na(D)] <- 0
    b <- -((log(functiond0)) / (log(d0)))
    D <- D^(-b)
  } else if (impFunction == "exponential") {
    D[is.na(D)] <- 0
    b <- -((log(functiond0)) / d0)
    D <- exp(-b * D)
  } else if (impFunction == "logistic") {
    D[is.na(D)] <- 0
    b <- -log((1 / functiond0) - 1) / d0 - mean(D)
    D <- 1 / 1(1 + exp(-b * (D - mean(D))))
  } else {
    stop("wrong parameters")
  }

  return(D)
}
