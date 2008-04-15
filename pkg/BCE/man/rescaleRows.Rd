\name{rescaleRows}
\alias{rescaleRows}
\title{rescale rows}
\description{returns a row-rescaled matrix}
\usage{rescaleRows(A, rescale=1:ncol(A))}
\arguments{
  \item{A }{matrix or dataframe to be row-rescaled: rowSums(A[rescale])=1}
  \item{rescale }{vector containing indices of the columns that should be included in the normalisation}
}
\value{
  \item{A }{row-rescaled matrix}
}
\author{Karel Van den Meersche}
\keyword{array}

