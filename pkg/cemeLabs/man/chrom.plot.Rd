\name{chrom.plot}
\alias{chrom.plot}
\title{
  Plots a chromatogram
}
\description{
  Plots a chromatogram data set
}

\usage{
chrom.plot (x, xvar="time", yvar="area", label="Name", marker = NULL,
             writelabels = FALSE, ...)

}
\arguments{
  \item{x }{input data, a \code{data.frame} whose chromatogram should be
    plotted
  }
  \item{xvar }{the name or the x-variable that should be plotted.
  }
  \item{yvar }{the name or the x-variable that should be plotted.
  }
  \item{label }{the name of the column that contains the labels. Used
    only when \code{writelabel} = \code{TRUE}
  }
  \item{marker }{if not \code{NULL}, a \code{data.frame} with biomarker
    information; this should contain the following columns:
    \code{name} with the name of the biomarker and \code{group} with the
    group for which this is a marker. Dataset \link{fa.marker} gives biomarker
    information for algae and bacteria.
  }
  \item{writelabels }{if  \code{TRUE} then the names of the variables
    are plotted
  }
  \item{...}{additional arguments passed to the functions.
  }
}
\examples{
  chrom.plot(fa.data)
  chrom.plot(fa.data, writelabel = TRUE, ylab="area", xlab="time",
            main ="DATA SET 1", marker = fa.marker)
}

\keyword{hplot}

