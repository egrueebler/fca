#' Distance weight methods
#'
#' @param D numeric matrix, distance or time values
#' @param d_max numeric, threshold for max distance
#' @param imp_function character, type of distance weights method
#' @param function_d_max numeric, condition for the result of the function(d_max) used to calculate beta (default = 0.01, is considered optimal for the Gaussian function)
#'
#' @return matrix, normalized distance or time values
#' @export
#'
#' @examples
#' dist_normalize(matrix(10), 10, "gaussian")
dist_normalize <- function(D, d_max, imp_function, function_d_max = 0.01) {
  D[is.na(D)] <- 0
  if (imp_function == "gaussian") {
    b <- -(d_max^2) / (log(function_d_max))
    W <- exp(-D^2 / b)
  } else if (imp_function == "gravity") {
    b <- -((log(function_d_max)) / (log(d_max)))
    W <- D^(-b)
  } else if (imp_function == "exponential") {
    b <- -((log(function_d_max)) / d_max)
    W <- exp(-b * D)
  } else if (imp_function == "logistic") {
    b <- -log((1 / function_d_max) - 1) / d_max - mean(D)
    W <- 1 / 1 * (1 + exp(-b * (D - mean(D))))
  } else {
    stop("Invalid `imp_function` value")
  }
  return(W)
}
