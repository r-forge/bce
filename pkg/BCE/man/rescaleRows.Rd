\name{rescaleRows}
\alias{rescaleRows}
\title{rescale rows}
\description{
returns a row-rescaled matrix (\code{rowSums(.)==1}).
}
\usage{rescaleRows(A, columns=1:ncol(A))
}

\arguments{
  \item{A }{matrix or dataframe to be row-rescaled:
    \code{rowSums(rescaleRows(A))==1}.
  }
  \item{columns }{vector containing indices of the columns that should
    be included in the normalisation.
  }
}
\value{
  \item{A }{row-rescaled matrix or partially row-rescaled matrix.
  }
}
\author{Karel Van den Meersche}
\keyword{array}

