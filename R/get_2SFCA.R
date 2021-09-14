#' Two-Step Floating Catchment Area method
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
#' spai <- get_2SFCA(p, s, D, "step2")
get_2SFCA <- function(p, s, D, step) {
  if (step == "step1") {
    D[D == 0] <- as.numeric(0)
    D[D > 0] <- as.numeric(1)
    step1 <- s / colSums(p * t(D))
    return(data.frame(step1))
  } else if (step == "step2") {
    D[D == 0] <- as.numeric(0)
    D[D > 0] <- as.numeric(1)
    step1 <- s / colSums(p * t(D))
    step2 <- colSums(D * step1)
    r <- colSums(D * s) / p
    return(data.frame(step2, r))
  } else {
    stop("wrong parameters")
  }
}
