#' Two-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param W numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' W <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_2sfca(p, s, W, step = 2)
spai_2sfca <- function(p, s, W, step = 2) {
  if (!step %in% seq_len(2)) stop("Invalid `step` value")
  W[W == 0] <- as.numeric(0)
  W[W > 0] <- as.numeric(1)
  step1 <- s / colSums(p * t(W))
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- colSums(W * step1)
  r <- colSums(W * s) / p
  return(data.frame(step2, r))
}

#' Three-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param W numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' W <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_3sfca(p, s, W, step = 3)
spai_3sfca <- function(p, s, W, step = 3) {
  if (!step %in% seq_len(3)) stop("Invalid `step` value")
  step1 <- sweep(W, 2, colSums(W), FUN = "/")
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- s / colSums(t(step1) * p * t(W))
  if (step == 2) {
    return(data.frame(step2))
  }
  step3 <- colSums(sweep(step1, 1, step2, FUN = "*") * W)
  return(data.frame(step3))
}

#' Modified-Huff-Three-Step Floating Catchment Area method
#'
#' @param p numeric vector, number of population at origin locations
#' @param s numeric vector, capacity of services at supply locations
#' @param W numeric matrix, distance or time matrix
#' @param step numeric, number of the steps of the method to perform
#'
#' @return data.frame, depending on selected step
#' @export
#'
#' @examples
#' p <- 1:4
#' s <- 1:6
#' W <- matrix(1:24, ncol = 4, nrow = 6)
#' spai <- spai_mh3sfca(p, s, W, step = 3)
spai_mh3sfca <- function(p, s, W, step = 3) {
  if (!step %in% seq_len(3)) stop("Invalid `step` value")
  step1 <- sweep(s * W, 2, colSums(s * W), FUN = "/")
  if (step == 1) {
    return(data.frame(step1))
  }
  step2 <- s / colSums(p * t(step1))
  if (step == 2) {
    return(data.frame(step2))
  }
  step3 <- colSums(step1 * W * step2)
  return(data.frame(step3))
}
