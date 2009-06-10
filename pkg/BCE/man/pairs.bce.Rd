\name{pairs.bce}
\alias{pairs.bce}
\title{A pairs plot of a BCE}
\description{
  produces a pairs plots of the random walks of the BCE.
}
\usage{pairs.bce(x,sample=1,gap=0,upper.panel = NA,
  diag.panel = NA,...)
}

\arguments{
  \item{x }{either a bce object or the random walk values (\code{X})
    of the composition matrix.
  }
  \item{sample }{the sample number for which the pairs plot is to be drawn.
  }
  \item{gap }{Distance between subplots, in margin lines - a \code{pairs}
    parameter.
  }
  \item{upper.panel}{panel function to be used above the diagonal - the
    default writes the correlations.
  }
  \item{diag.panel}{panel function to be used on the diagonal - the default
    plots a histogram.
  }
  \item{...}{any other parameters passed to function \code{pairs}.
  }
}

\seealso{
  \code{\link{BCE}}, \code{\link{summary.bce}},
  \code{\link{plot.bce}}, \code{\link{export.bce}}
}

\examples{
# bceOutput is an example output based on bceInput

pairs(bceOutput,sample=2,main="Station 2")
}
\author{Karline Soetaert}
\keyword{hplot}

