\name{BCE-package}
\alias{BCE-package}
\docType{package}
\title{
  The Bayesian Compositional Estimator Package
}
\description{
  Functions that estimate sample (taxonomic) composition from
  biomarker data

  \code{bce} estimates probability distributions of a sample composition
  based on an \bold{input ratio matrix}, \code{A}, containing
  biomarker ratios in (field) samples, and an \bold{input data matrix},
  \code{B}, containing the biomarker ratios for several taxonomic groups

  \code{tlsce} estimates the total least squares solution
  
  This version differs from the previous version <2 in that a different
  MCMC method is used that shows better convergence properties.
  
}
\details{
  \tabular{ll}{
    Package: \tab BCE\cr
    Type:    \tab Package\cr
    License: \tab GNU Public License 2 or above\cr
  }


}
\author{
  Karel Van den Meersche (Maintainer)

  Karline Soetaert
}
\references{
  Van den Meersche, K., K. Soetaert and J.J. Middelburg (2008) \emph{A
    Bayesian compositional estimator for microbial taxonomy
    based on biomarkers}, Limnology and Oceanography Methods 6, 190-199
}

\seealso{
  \code{\link{bce}} the new function, with better convergence properties
  
  \code{\link{BCE}} the original function (versions < 2)

  \code{\link{tlsce}} total least squares compositional estimator
}

\examples{
\dontrun{
## show examples (see respective help pages for details)
example(bce)
example(tlsce)

## show package vignette
browseURL(paste(system.file(package = "BCE"), "/doc", sep = ""))
}
}

\keyword{ package }