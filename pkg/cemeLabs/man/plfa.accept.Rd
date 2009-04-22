\name{plfa.accept}
\alias{plfa.accept}
\title{
  Accepts the defaults of the fatty acid chromatography data
}
\description{
  Accepts the defaults of the plfa analysis function. This avoids having
  to manually make decisions on which plfas correspond to ambiguous peaks.
  
  (Note that the manual decision- using the edit command - is recommended).
}

\usage{
plfa.accept(PLFA)

}
\arguments{
  \item{PLFA }{input data.frame as resulting from function \code{plfa}
  }
}

\examples{
  PLFA <- plfa(input=fa.data, qty_standard=2.01,
               volume_chlor = 15, weight_chlor=20)
  PLFA <- plfa.accept(PLFA)
}

\keyword{utilities}

