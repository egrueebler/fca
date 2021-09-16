#' Two-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param D numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' D <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_2sfca(p, s, D, step = 2)
spai_2sfca <- function(p, s, D, step = 2) {
  if (!step %in% seq_len(2)) stop("Invalid `step` value")
  D[D == 0] <- as.numeric(0)
  D[D > 0] <- as.numeric(1)
  step1 <- s / colSums(p * t(D))
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- colSums(D * step1)
  r <- colSums(D * s) / p
  return(data.frame(step2, r))
}

#' Three-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param D numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' D <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_3sfca(p, s, D, step = 3)
spai_3sfca <- function(p, s, D, step = 3) {
  if (!step %in% seq_len(3)) stop("Invalid `step` value")
  step1 <- sweep(D, 2, colSums(D), FUN = "/")
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- s / colSums(t(step1) * p * t(D))
  if (step == 2) {
    return(data.frame(step2))
  }
  step3 <- colSums(sweep(step1, 1, step2, FUN = "*") * D)
  return(data.frame(step3))
}

#' Modified-Huff-Three-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param D numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' D <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_mh3sfca(p, s, D, step = 3)
spai_mh3sfca <- function(p, s, D, step = 3) {
  if (!step %in% seq_len(3)) stop("Invalid `step` value")
  step1 <- sweep(s * D, 2, colSums(s * D), FUN = "/")
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- s / colSums(p * t(step1))
  if (step == 2) {
    return(data.frame(step2))
  }
  step3 <- colSums(step1 * D * step2)
  return(data.frame(step3))
}
