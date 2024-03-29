% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fca.R
\name{spai_3sfca}
\alias{spai_3sfca}
\title{Three-Step Floating Catchment Area method}
\usage{
spai_3sfca(p, s, W, step = 3)
}
\arguments{
\item{p}{numeric vector, number of population at origin locations}

\item{s}{numeric vector, capacity of services at supply locations}

\item{W}{numeric matrix, distance or time matrix}

\item{step}{numeric, number of the steps of the method to perform}
}
\value{
data.frame, depending on selected step
}
\description{
Three-Step Floating Catchment Area method
}
\examples{
p <- 1:4
s <- 1:6
W <- matrix(1:24, ncol = 4, nrow = 6)
spai <- spai_3sfca(p, s, W, step = 3)
}
