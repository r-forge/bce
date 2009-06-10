\name{bceInput}
\docType{data}
\alias{bceInput}
\title{
  ratiomatrix and datamatrix for demonstration of BCE().
}
\description{
  The datamatrix contains a set of biomarker measurements for a number
  of field samples.

  The ratiomatrix contains biomarker data of a number of biological taxa.
  \code{BCE()} uses these matrices to estimate the taxonomical composition
  of the samples based on the provided taxa.
}

\usage{bceInput}

\examples{
##====================================
## Graphical representation of the example input data
palette(rainbow(12, s = 0.6, v = 0.75))

mp     <- apply(bceInput$Rat,MARGIN=2,max)
mp2    <- apply(bceInput$Dat,MARGIN=2,max)
pstars <- rbind(t(t(bceInput$Rat)/mp),t(t(bceInput$Dat)/mp2))

stars(pstars, len = 0.9, key.loc = c(7.2, -2),scale=FALSE,
      ncol=5,ylim=c(0,3),main = "bce Input: species + field samples", 
      draw.segments = TRUE, flip.labels=FALSE)
}
\keyword{datasets}

