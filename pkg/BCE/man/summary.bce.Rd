\name{summary.bce}
\alias{summary.bce}
\title{summary BCE}
\description{basic statistics of a bce object}
\usage{summary.bce(mcmc, confInt=2/3)}
\arguments{
  \item{mcmc }{a bce-object, output of the function bce()}
  \item{confInt }{confidence interval of values of composion matrix and ratio matrix}
}
\value{
  a list containing:
  \item{firstX }{X determined through least squares regression from the initial ratio matrix and the data matrix}
  \item{bestRat }{Ratio matrix for which the posterior probability is maximal}
  \item{bestX }{Composition matrix for which the posterior probability is maximal}
  \item{bestp }{Maximal posterior probability}
  \item{bestDat }{Product of \code{bestRat} and \code{bestX}}
  \item{meanRat }{Means of the elements of the ratio matrix}
  \item{sdRat }{Standard deviation of the elements of the ratio matrix}
  \item{lbRat }{Lower boundary of the confidence interval of the elements of the ratio matrix}
  \item{ubRat }{Upper boundary of the confidence interval of the elements of the ratio matrix}
  \item{covRat }{Covariance matrix of the elements of the ratio matrix}
  \item{meanX }{Means of the elements of the composition matrix}
  \item{sdX }{Standard deviation of the elements of the composition matrix}
  \item{lbX }{Lower boundary of the confidence interval of the elements of the composition matrix}
  \item{ubX }{Upper boundary of the confidence interval of the elements of the composition matrix}
  \item{covX }{Covariance matrix of the elements of the composition matrix}
}
\author{Karel Van den Meersche}
\examples{
# bceOutput is an example output based on bceInput

summary(bceOutput)
}

\keyword{models}

