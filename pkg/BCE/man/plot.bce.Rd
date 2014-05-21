\name{plot.bce}
\alias{plot.bce}
\title{plot BCE}
\description{
  produces summary plots of the random walks of the BCE; these are
  intended for inspection only.
}
\usage{
\method{plot}{bce}(x, \dots)
}

\arguments{
  \item{x }{an object of class bce and/or _modMCMC_. Output of one of
  the functions \code{\link{BCE}} or \code{\link{bce1}}. 
  }
  \item{... }{additional arguments.
  }
}

\details{
  When the argument an object is of class _modMCMC_, which is the case
  if it is the output of \code{bce1()}, it is treated as such (see
  \code{\link{modMCMC}}). 
  
  Calling the plot-function with the output of \code{\link{BCE}} as argument, will produce
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

