\name{fa.data}
\docType{data}
\alias{fa.data}
\alias{irms.data}
\title{
  Data sets
}

\description{
  Example fa dataset obtained by gas chromatography with flame
  ionization detection.
}

\usage{
fa.data
irms.data

}

\format{
  a data.frame
}


\examples{
fa.data
chrom.plot(fa.data, xlab="ECL", ylab="peak area", main="plfa dataset",
          writelabels=TRUE)

chrom.plot(irms.data, xlab="ECL", ylab="peak area", main="irms dataset")
chrom.plot(irms.data, yvar = "d13C",xlab="ECL", ylab="d13C", main="irms dataset")
chrom.plot(irms.data, yvar = "d18O",xlab="ECL", ylab="d18O", main="irms dataset")

}
\references{
}

\keyword{datasets}
