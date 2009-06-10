\name{tlsce}
\alias{tlsce}
\title{Total Least Squares Composition Estimator}
\description{
  estimates a matrix X for which:
  \deqn{(A+\epsilon_A)X = B+\epsilon_B}
  minimize \eqn{\sum{\epsilon_A^2 + \epsilon_B^2}}
  \deqn{\sum{X_{i,}}=1 \forall i}
  \deqn{X>0}
  the elements of \eqn{\epsilon_A} are NULL if the corresponding
  elements of A are NULL. 
  A typically contains biomarker concentrations for several taxonomic groups,
  and B field measurements of the same biomarkers. X is then an estimate
  of the taxonomic composition of the field sample.
}

\usage{tlsce(A, B, Wa=NULL, optimizationfunction="nlminb",
  A_init=A, Xratios=TRUE, ...)
}

\arguments{
  \item{A }{a matrix or data frame. If A contains biomarker data for
    taxonomic groups, the biomarkers have to be organized per row, and
    the taxonomic groups per column.
  }
  \item{B }{a matrix or data frame. If B contains biomarker field data,
    the biomarkers have to be organized per row, and the samples per
    column.
  }
  \item{Wa }{weighting of A, a matrix with the same dimensions of A. If
    \code{Wa=NULL}, Wa defaults to 1. This parameter can be used to give
    more importance to elements of A or A in total compared to
    B. Weighting of B is not possible. the weights are implemented as
    proportional to \eqn{1/s} (as opposed to \eqn{1/s^2}) with s the
    standard deviation of the error term.
  }
  \item{optimizationfunction }{the function used for the optimization of
    A (one of "nlminb","optim","constrOptim").
  }
  \item{A_init }{a matrix with the same structure as A. a general,
    non-linear optimization routine (default \code{nlminb}) is used to
    minimize the sum of squared residuals of A versus the fitted matrix
    A\_fit (see falue). This optimization routine requires a set of
    starting values, by default the non-zero elements of A. This
    provides a good fit, but when in doubt about the convergence of the
    algorithm, one can provide different starting values for the
    optimization routine in A\_init.}
  \item{Xratios }{TRUE or FALSE: are the colSums of the matrix X equal
    to 1? This is for example the case in a compositional matrix.}
  \item{...}{Arguments to be passed to the optimization function in
    use.
  }
}

\details{
  instead of a linear least squares regression, in which the
  elements of A would be fixed, the function \code{tlsce} includes the
  non-zero elements of A in the least squares regression. This is
  similar to other total least squares regression methods, with the main
  difference that only non-zero elements of A contain an error term. 
}  

\value{
  A list with the following elements:
  \item{X }{ Array with dimension c(nrow(\code{Rat}),ncol(\code{Rat}),
    \code{iter}) containing the random walk values of the ratio matrix \code{Rat}}
  \item{A\_fit }{ Array with dimension c(nrow(\code{X}),ncol(\code{X}),
    \code{iter}) containing the random walk values of the composition matrix \code{X}}
  \item{B\_fit }{ vector with length \code{iter} containing the random}
  \item{solutionNorms }{a vector of 3 values: the value of the minimised
    quadratic function at
    the solution, in this case
    \eqn{\sum{(Afit-A)*Wa)^2 + (Bfit-B)^2}}{sum((Afit-A)*Wa)^2 + (Bfit-B)^2)}, and the
    shares of this value attributed to A and to B}
  \item{convergence }{An integer code. '0' indicates successful convergence.}
}

\references{
  Van den Meersche, K., K. Soetaert and J.J. Middelburg (2008) \emph{A
    Bayesian compositional estimator for microbial taxonomy
    based on biomarkers}, Limnology and Oceanography Methods 6, 190-199
}

\seealso{
  \code{\link{BCE}}
}

\examples{
A <- t(bceInput$Rat)
B <- t(bceInput$Dat)
tlsce(A,B)
## weighting Wa inversely proportional to A
tlsce(A,B,Wa=1/A)
}
\author{Karel Van den Meersche <k.vdmeersche@nioo.knaw.nl>,
  Karline Soetaert <k.soetaert@nioo.knaw.nl>
}
\keyword{models}

