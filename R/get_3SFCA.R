#' Three-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param D matrix, distance or time matrix
#' @param step character, step of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' D <- matrix(1:24, ncol=4, nrow=6)
#' spai <- get_3SFCA(p, s, D, "step3")
#'
get_3SFCA <- function(p, s, D, step) {
  if (step == "step1") {
    step1 <- sweep(D, 2, colSums(D), FUN = "/")
    return(data.frame(step1))
  } else if (step == "step2") {
    step1 <- sweep(D, 2, colSums(D), FUN = "/")
    step2 <- s / colSums(t(step1) * p * t(D))
    return(data.frame(step2))
  } else if (step == "step3") {
    step1 <- sweep(D, 2, colSums(D), FUN = "/")
    step2 <- s / colSums(t(step1) * p * t(D))
    step3 <- colSums(sweep(step1, 1, step2, FUN = "*") * D)
    return(data.frame(step3))
  } else {
    stop("wrong parameters")
  }
}
