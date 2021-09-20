#' Distance weight methods
#'
#' @param D numeric matrix, distance or time values
#' @param d_max numeric, threshold for max distance
#' @param imp_function character, type of distance weights method
#' @param function_d_max numeric, result for function(d_max)
#'
#' @return matrix, normalized distance or time values
#' @export
#'
#' @examples
#' dist_normalize(matrix(10), 10, "gaussian")
dist_normalize <- function(D, d_max, imp_function, function_d_max = 0.01) {
  if (imp_function == "gaussian") {
    D[is.na(D)] <- 0
    b <- -(d_max^2) / (log(function_d_max))
    D <- exp(-D^2 / b)
  } else if (imp_function == "gravity") {
    D[is.na(D)] <- 0
    b <- -((log(function_d_max)) / (log(d_max)))
    D <- D^(-b)
  } else if (imp_function == "exponential") {
    D[is.na(D)] <- 0
    b <- -((log(function_d_max)) / d_max)
    D <- exp(-b * D)
  } else if (imp_function == "logistic") {
    D[is.na(D)] <- 0
    b <- -log((1 / function_d_max) - 1) / d_max - mean(D)
    D <- 1 / 1(1 + exp(-b * (D - mean(D))))
  } else {
    stop("Invalid `imp_function` value")
  }
  return(D)
}
