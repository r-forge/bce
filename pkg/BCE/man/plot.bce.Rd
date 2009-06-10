\name{plot.bce}
\alias{plot.bce}
\title{plot BCE}
\description{
  produces summary plots of the random walks of the BCE; these are
  intended for inspection only.
}
\usage{plot.bce(x,...)}

\arguments{
  \item{x }{bce object.
  }
  \item{... }{additional arguments.
  }
}

\details{
  Calling the plot-function with a bce-object as argument, will produce
  a series of plots with the random walks of each variable. The layout
  of these plots is kept very sober, as they are primarily intended for
  inspection of the random walk (see \code{\link{BCE}}). Users
  are free to write their own publication quality plots. Click or hit
  Enter to see the next plot, hit Esc to stop seeing new plots. 
}
  
\seealso{
  \code{\link{BCE}}, \code{\link{summary.bce}},
  \code{\link{export.bce}}, \code{\link{pairs.bce}}
}

\author{Karel Van den Meersche}
\examples{
# bceOutput is an example output based on bceInput

plot(bceOutput)
}

\keyword{models}

