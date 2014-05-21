\name{export.bce}
\alias{export.bce}
\title{export BCE}
\description{export function: writes a BCE-object and its summary
  statistics to a series of files.
}
\usage{export.bce(x, file="BCE", input.list=NULL, ...)
}
\arguments{
  \item{x }{a bce object, output of the function BCE().
  }
  \item{file }{file to which the bce object is written.
  }
  \item{input.list }{a list of the arguments in bce() can be provided
    and saved as well.
  }
  \item{... }{additional arguments.
  }
}
\details{
  The bce object is saved (\code{\link{save}}) to the specified file.
  For people not familiar to R, it can be more 'user-friendly' to export
  summary results to comma delimited textfiles, that can be
  easily imported into a spreadsheet program. The function
  \code{\link{summary.bce}} is called to
  calculate summary statistics of a BCE object; These are then written
  to a series of .csv files with a name that combines the specified
  filename and a string indicating the content of the .csv files. 
  Traces and marginal probabilities of all estimated values are plotted
  and saved in .png files. These traces should be inspected carefully
  before accepting any results (see also \code{\link{plot.bce}}).
}


\seealso{
  \code{\link{BCE}}, \code{\link{summary.bce}},
  \code{\link{plot.bce}}, \code{\link{pairs.bce}}
}

\examples{

\dontrun{export.bce(bceOutput, file="bceOutput")}

}
\author{Karel Van den Meersche}
\keyword{IO}

