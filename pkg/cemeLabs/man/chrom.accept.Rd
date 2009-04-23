\name{chrom.accept}
\alias{chrom.accept}
\title{
  Accepts the defaults of the chromatography data
}
\description{
  Accepts the defaults of the plfa or irms analysis function. This avoids having
  to manually make decisions on which plfas correspond to ambiguous peaks.
  
  (Note that the manual decision- using the edit command - is recommended).
}

\usage{
chrom.accept(chrom)

}
\arguments{
  \item{chrom }{input data.frame as resulting from function \code{plfa} or
    from function \code{irms}
  }
}

\examples{
  PLFA <- plfa(input=fa.data, qty_standard=2.01,
               volume_chlor = 15, weight_chlor=20)
  PLFA <- chrom.accept(PLFA)
}

\keyword{utilities}

