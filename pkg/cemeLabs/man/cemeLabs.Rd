\name{cemeLabs-package}
\alias{cemeLabs-package}
\alias{cemeLabs}
\title{Ceme Lab Analysis Functions}
\description{
facilitates conversion of lab files to result files from the CEME,
centre for estuarine and marine ecosystems, Yerseke, the netherlands.

Includes
  \itemize{
    \item Analysis of fatty acid chromatogram data from
        GC-FID carlo erba HRGC mega 2 GC

  }
}

\details{
  \tabular{ll}{
    Package: \tab cemeLabs\cr
    Type: \tab Package\cr
    Version: \tab 1.0\cr
    Date: \tab 2009-04-01\cr
    License: \tab GNU Public License 2 or above\cr
  }

}

\author{
  Pieter Provoost

  Karline Soetaert (maintainer)

}
\seealso{

  \code{\link{plfa}}, phospholipid-derived fatty acid analysis
  
  \code{\link{plotchrom}}, plot a chromatogram

}

\examples{
\dontrun{
## show examples (see respective help pages for details)
example(plfa)
example(plotchrom)

## run demos
demo("plfa") # nog te maken

## open the directory with source code of demos
browseURL(paste(system.file(package="cemeLabs"), "/demo", sep=""))

## show package vignette - nog te maken
vignette("cemeLabs")
browseURL(paste(system.file(package="cemeLabs"), "/doc", sep=""))
}
}

\keyword{ package }
