\name{summary.bce}
\alias{summary.bce}
\title{summary BCE}
\description{basic statistics of a bce object}
\usage{summary.bce(mcmc, confidenceInterval=2/3)}
\arguments{
  \item{mcmc }{a bce-object, output of the function bce()}
  \item{confidenceInterval }{confidence interval of values of composion matrix and ratio matrix}
}
\value{
  a list containing:
  \item{firstx }{x determined through least squares regression from the initial ratio matrix and the data matrix}
  \item{bestrat }{ratio matrix for which the posterior probability is maximal}
  \item{bestx }{composition matrix for which the posterior probability is maximal}
  \item{bestp }{maximal posterior probability}
  \item{bestdat }{product of bestrat and bestx}
  \item{meanrat }{means of the elements of the ratio matrix}
  \item{sdrat }{standard deviation of the elements of the ratio matrix}
  \item{lbrat }{lower boundary of the confidence interval of the elements of the ratio matrix}
  \item{ubrat }{upper boundary of the confidence interval of the elements of the ratio matrix}
  \item{covrat }{covariance matrix of the elements of the ratio matrix}
  \item{meanx }{means of the elements of the composition matrix}
  \item{sdx }{standard deviation of the elements of the composition matrix}
  \item{lbx }{lower boundary of the confidence interval of the elements of the composition matrix}
  \item{ubx }{upper boundary of the confidence interval of the elements of the composition matrix}
  \item{covx }{covariance matrix of the elements of the composition matrix}
}
\author{Karel Van den Meersche}
\keyword{models}

