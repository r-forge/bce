\name{fa.columns}
\docType{data}
\alias{fa.columns}
\alias{fa.bpx70}
\alias{fa.apolar}
\alias{fa.polar1}
\alias{fa.polar2}
\alias{fa.zb5}
\alias{irms.bpx70}

\title{
  Input data set for the different FAME columns
}

\description{
  Input datasets for the FAME columns. The following are distinguished:
  \itemize{
    \item \code{fa.bpx70}, the BPX70 (GC-04 PTV); date June 2008
    \item \code{fa.zb5}, the ZB-5 column (GC-05 SSL LV); date March 2008
    \item \code{fa.apolar}, "a-polair"
    \item \code{fa.polar1}, "polair bpx70 - Eric Boschker"
    \item \code{fa.polar2}, "polair bpx70 - Marco Houttekamer" date nov 2004
  }
}

\usage{
fa.bpx70

}

\format{
  a \code{data.frame} with \code{ecl}, the equivalent chain length and
  \code{name}, the corresponding name of the plfa
}


\examples{
fa.bpx70

ecl  <- fa.bpx70$ecl
name <- fa.bpx70$name
plot(0,axes=FALSE,ylim=range(ecl),xlim=c(0,1),
     ylab="ecl",xlab="",main="bpx70",frame.plot=TRUE)
axis(2)
axis(4)
ll <- length(ecl)

i1 <- seq(1,ll-2,by=3)
i2 <- i1+1
i3 <- i2+1

text(y=ecl[i1],x=0.1,labels=name[i1],cex=0.75,adj=c(0,0.5),col="red")
segments(0,ecl[i1],0.05,ecl[i1],lty=2,col="red")
text(y=ecl[i2],x=0.4,labels=name[i2],cex=0.75,adj=c(0,0.5),col="darkblue")
segments(0,ecl[i2],0.35,ecl[i2],lty=2,col="darkblue")
text(y=ecl[i3],x=0.7,labels=name[i3],cex=0.75,adj=c(0,0.5))
segments(0,ecl[i3],0.65,ecl[i3],lty=2)

}
\references{
}

\keyword{datasets}
