\name{summary.bce}
\alias{summary.bce}
\title{summary BCE}
\description{basic statistics of a bce object}
\usage{
\method{summary}{bce}(object, confInt = 2/3, ...)
}
\arguments{
  \item{object }{a bce-object, output of the function bce1() or BCE().
  }
  \item{confInt }{confidence interval of values of composion matrix and
    ratio matrix.
  }
  \item{... }{additional arguments affecting the summary produced.
  }
}
\value{

  if object is output of the function bce1():

  a list containing:
  \item{meanA }{Average solution of the ratio matrix,found through MCMC.
  }
  \item{meanX }{Average solution of the composition matrix, found
  through MCMC.
  }
  \item{bestA }{Ratio matrix for which the posterior probability is
    maximal.
  }
  \item{bestX }{Composition matrix for which the posterior probability is
    maximal.
  }
  \item{sdA }{standard deviation of the ratio matrix.
  }
  \item{sdX }{standard deviation of the composition matrix.
  }
  \item{lastA }{Last value for the ratio matrix in the MCMC run. 
  }
  \item{lastX }{Last value for the composition matrix in the MCMC run. 
  }
  \item{medianA }{Median of the ratio matrix.
  }
  \item{medianX }{Median of the composition matrix.
  }
  \item{ubA }{Upper boundary of the confidence interval of the elements of
    the ratio matrix.
  }
  \item{ubX }{Upper boundary of the confidence interval of the elements of
    the composition matrix.
  }
  \item{lbA }{Lower boundary of the confidence interval of the elements of
    the ratio matrix.
  }
  \item{lbX }{Lower boundary of the confidence interval of the elements of
    the composition matrix.
  }
  \item{covar }{Covariance matrix of all elements of A and X.
  }

  
  if object is output of the function BCE():

  a list containing:
  \item{firstX }{X determined through least squares regression from the
    initial ratio matrix and the data matrix.
  }
  \item{bestRat }{Ratio matrix for which the posterior probability is maximal.
  }
  \item{bestX }{Composition matrix for which the posterior probability is
    maximal.
  }
  \item{bestp }{Maximal posterior probability.
  }
  \item{bestDat }{Product of \code{bestRat} and \code{bestX}.
  }
  \item{meanRat }{Means of the elements of the ratio matrix.
  }
  \item{sdRat }{Standard deviation of the elements of the ratio matrix.
  }
  \item{lbRat }{Lower boundary of the confidence interval of the elements
    of the ratio matrix.
  }
  \item{ubRat }{Upper boundary of the confidence interval of the elements
    of the ratio matrix.
  }
  \item{covRat }{Covariance matrix of the elements of the ratio matrix.
  }
  \item{meanX }{Means of the elements of the composition matrix.
  }
  \item{sdX }{Standard deviation of the elements of the composition matrix.
  }
  \item{lbX }{Lower boundary of the confidence interval of the elements of
    the composition matrix.
  }
  \item{ubX }{Upper boundary of the confidence interval of the elements
    of the composition matrix.
  }
  \item{covX }{Covariance matrix of the elements of the composition matrix.
  }
}
\seealso{
  \code{\link{bce1}}, \code{\link{BCE}}, \code{\link{plot.bce}},
  \code{\link{export.bce}}, \code{\link{pairs.bce}}
}


\author{
  Karel Van den Meersche
}
\examples{
# bceOutput is an example output based on bceInput

summary(bceOutput)
}

\keyword{models}

