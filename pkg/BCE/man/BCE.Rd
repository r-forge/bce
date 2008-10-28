\name{BCE}
\alias{BCE}
\title{Bayesian Composition Estimator}
\description{estimates probability distributions of a sample composition
  based on 
  \item an \bold{input ratio matrix}, \code{Rat}, containing biomarker ratios in (field)
  samples, and 
  \item an \bold{input data matrix}, \code{Dat}, containing the biomarker
  ratios for several taxonomic groups}
\usage{BCE(Rat, Dat, relsdRat = 0, abssdRat = 0, minRat = 0, 
maxRat = +Inf, relsdDat = 0, abssdDat = 0, tol = 1e-4, tolX = 1e-4, 
positive = 1:ncol(Rat), iter = 100, outputlength = 1000, 
burninlength = 0, jmpRat = 0.01, jmpX = 0.01, unif = FALSE, 
verbose = TRUE, initRat = Rat, initX = NULL, userProb = NULL, 
confInt = 2/3, export = FALSE, file = "BCE")}
\arguments{
  \item{Rat }{initial ratio matrix. Each row of \code{Rat} contains the biomarker composition
    of one taxon. As a result of the Bayesian procedure, this initial ratio matrix will be altered}
  \item{Dat }{initial data matrix. Each row of \code{Dat} contains the biomarker composition of 
    one (field) sample.}
  \item{relsdRat }{relative standard deviation on ratio matrix. Either one number or a matrix with 
    the same dimensions as \code{Rat}}
  \item{abssdRat }{absolute standard deviation on ratio matrix. Either one number or a matrix with 
    the same dimensions as \code{Rat}}
  \item{minRat }{minimum values of ratio matrix. Either one number or a matrix with 
    the same dimensions as \code{Rat}}
  \item{maxRat }{maximum values of ratio matrix. Either one number or a matrix with 
    the same dimensions as \code{Rat}}
  \item{relsdDat }{relative standard deviation on data matrix. Either one number or a matrix with 
    the same dimensions as \code{Dat}}
  \item{abssdDat }{absolute standard deviation on data matrix. Either one number or a matrix with 
    the same dimensions as \code{Dat}}
  \item{tol }{minimum standard deviation for data matrix \code{Dat}. One value}
  \item{tolX }{minimum x values. Used for MCMC initiation. One value}
  \item{positive }{A vector containing numbers of columns that should
    contain strictly positive data.  Only these columns are rescaled. The
    other columns (not in \code{positive}) are not rescaled, and can become
    negative}
  \item{iter }{number of iterations for MCMC}
  \item{outputlength }{number of iterations kept in the output}
  \item{burninlength }{number of initial iterations to be removed from output}
  \item{jmpRat }{jump length of the ratio matrix \code{Rat} (in normal
    space).  Either a number, a vector with length equal to the number of
    biomarkers (number of columns in \code{Rat}), or a or matrix with the
    same dimensions as the ratio matrix \code{rat}}
  \item{jmpX }{jump length of the composition matrix (in a
    simplex). Either one number, a vector of length equal to the number of
    taxa (number of rows in \code{Rat})
    or a matrix with the same dimensions = c(number of taxa, number of
    field samples)}
  \item{unif }{logical; if TRUE a uniform distribution for ratio matrix
    is used. This is similar as in chemtax}
  \item{verbose }{logical; if TRUE, extra information is provided during
    the run of the function, such as extra warnings, elapsed time and
    expected time until the end of the MCMC }
  \item{initRat }{ratio matrix used to start the markov chain: defaults
    to the initial ratio matrix}
  \item{initX }{composition matrix used to start the markov chain:
    default the LSEI solution of Ax=B}
  \item{userProb }{function taking two arguments: ratio matrix RAT and
    composition matrix X, and returning the posterior probability.
    Dependence of the probability on the data should be incorporated in
    the function. If not specified, the default probability distribution
    is the product of a non-informative distribution on the composition
    matrix, and gamma distributions for the ratio matrix and the data
    given the model output. }
  \item{confInt }{confidence interval in output; because the
    distributions may not be symmetrical, standard deviations are not
    always a useful measure; instead, upper and lower boundaries of the
    given confidence interval are given.  Default is 2/3, i.e there is a
    probability of 0.66 for a value to be contained within the interval.}
  \item{export }{logical; if \code{TRUE}, the function
    \code{\link{export.bce}} is called and a list of variables and plots
    are exported to the specified \code{file}.}
  \item{file }{Only if \code{export} is TRUE. If not NULL, a
    character string specifying the file to which objects are saved. }
}

\details{
  The function \code{\BCE} searches probability distributions for all
  elements of a taxonomical composition matrix \code{X} and a ratio
  matrix \code{Rat} for which:

  \deqn{X\%*\%Rat \simeq Dat}{X\%*\%Rat ~= Dat}
  
  It does this by returning \code{iter} samples for X and Rat, organized
  in three-dimensional arrays. The input
  data matrix \code{Dat} and ratio matrix \code{Rat} should be
  in the following formats, with the relative concentrations per
  biomarker organized in columns:

  data matrix:
  \tabular{ccccc}{
    \tab  marker1 \tab  marker2 \tab  marker3 \tab  marker4  \cr
    sample1  \tab  0.14 \tab  0.005  \tab  0.35	 \tab	0.033  \cr
    sample2  \tab  0.15	\tab  0.004  \tab  0.36	 \tab	0.034  \cr
    sample3  \tab  0.13	\tab  0.004  \tab  0.31  \tab	0.030  \cr
    sample4  \tab  0.13	\tab  0.005  \tab  0.33	 \tab	0.031  \cr
    sample5  \tab  0.14	\tab  0.008  \tab  0.33  \tab	0.036  \cr
    sample6  \tab  0.11	\tab  0.082  \tab  0.34  \tab	0.044
  }

  and ratio matrix:
  \tabular{ccccc}{
    \tab  marker1  \tab  marker2 \tab	marker3	\tab	marker4	\cr
    species1  \tab  0.27     \tab  0.13	   \tab	0.35	\tab	0.076	\cr
    species2  \tab  0.084    \tab  0	   \tab	0.5	\tab	0.24	\cr
    species3  \tab  0.195    \tab  0.3	   \tab	0	\tab	0.1	\cr
    species4  \tab  0.06     \tab  0	   \tab	0	\tab	0	\cr
    species5  \tab  0	     \tab  0	   \tab	0	\tab	0	\cr
    species6  \tab  0	     \tab  0	   \tab	0	\tab	0
  }
}

\value{
  A bce (bayesian compositional estimator) object; a list containing 4 elements
  \item{Rat }{ Array with dimension c(nrow(\code{Rat}),ncol(\code{Rat}),\code{iter}) containing the random walk values of the ratio matrix \code{Rat}}
  \item{X }{ Array with dimension c(nrow(\code{X}),ncol(\code{X}),\code{iter}) containing the random walk values of the composition matrix \code{X}}
  \item{logp }{ vector with length \code{iter} containing the random
    walk values of the (log) posterior probability}
  \item{naccepted }{ integer indicating the number of runs that were accepted}
}

\note{
  Producing sensible output:

  Markov Chain Monte Carlo simulations are not as straightforward as one
  might wish; several preliminary runs might be necessary to determine
  the desired number of iterations, burn-in length and jump
  length. For all estimated values of Rat and X, their trace
  (evolution of the values over all iterations) has to display random
  behaviour; no obvious trends should appear. A few parameters can be
  tuned to obtain such behaviour:

  \itemize{
    \item{\bold{jump length} }{The jump length determines how big the jumps are
    for each step in the random walk. A longer jump length will make you
    jump around faster in the parameter space, but acceptance of new
    points can get very low. Smaller jump lengths increase the
    acceptance rate, but the algorithm will move too slowly, and a lot
    more runs will be needed to scan the whole parameter space. A good
    way to find a good jump length, is look at the number of points
    accepted. If the output is saved under the name \code{MCMC}, you
    can find the number of accepted points under
    \code{MCMC$naccepted}. It is also given if you run the model with
    \code{verbose=TRUE} (default). This value should be somewhere
    between 5\% and 40\%. For long runs, 5 \% can be acceptable, for
    short runs, you will prefer a higher acceptance in order to have
    enough different points. 20\% accepted is usually a good number. Do
    some preliminary runs with \code{iter=1000-10000} and tune the
    jump length parameters \code{jmpRat} and \code{jmpX}. You can set
    different jump lengths for each column of
    the ratio matrix, or 1 jump length for the whole ratio matrix, and 1
    jump length for the composition matrix. Decreasing the jump lengths
    will generally increase the acceptance rate and vice versa. Also the
    mixing rate (the speed with which accepted points change their
    values) will be influenced. You want this mixing rate to be as high
    as possible, whilst maintaining enough accepted points. }

    \item{\bold{burninlength} }{The program uses the solution of lsei using the
    original ratio matrix as starting values for the MCMC. This might in
    some cases be far from the optimal solution, and the MCMC algorithm
    will start with moving towards this optimal solution. This is called
    a burn-in. When there is a slow mixing rate, this can take a
    considerable number of cycles. As it can influence the averages and
    standard deviations, you might want to remove it from the mcmc
    objects. By defining a burnin length, the first
    '\code{burninlength}' cycles will not be written to the output. Look
    at some plots to determine if you need to specify a burnin length.}

    \item{\bold{iter} }{the number of iterations: start with 10000 runs
    or less; check the output and estimate how many runs you will need
    to get a random pattern in the output.}
  }
}

\references{
  Van den Meersche, K., K. Soetaert and J.J. Middelburg (2008) \emph{A
    Bayesian compositional estimator for microbial taxonomy
    based on biomarkers}, Limnology and Oceanography Methods 6, 190-199
  }
 
\seealso{
  \code{\link{summary.bce}}, \code{\link{plot.bce}},
  \code{\link{export.bce}}, \code{\link{pairs.bce}}
}

\examples{
##====================================

# example using bceInput data
# first try

X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
         iter=1000,outputlength=5000,jmpX=.01,jmpRat=.01)

## the number of accepted runs is too low;
## we play around with the jump lengths jmpx and jmprat

X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
         iter=1000,outputlength=5000,jmpX=.02,jmpRat=.002)

## we inspect the output:
plot(X)

## For every element of X and Rat, we want to obtain a well-mixed,
## random trace. In this case, mixing is still a little poor.
## to optimize mixing in the ratio matrix, it is a good idea
## to make the jump length linear to the ratio matrix
## standard deviation (sdrat=.2*rat) :
X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
         iter=1000,outputlength=5000,jmpX=.02,
         jmpRat=.2*(.2*bceInput$Rat))
plot(X)

## mixing improved a lot; we repeat the run with more iterations
## to improve the reliability of the results.
## the following run can take a few minutes - so it is toggled off
#X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
#         iter=100000,outputlength=5000,jmpX=.02,
#         jmpRat=.2*(.2*bceInput$Rat))
#plot(X)
## you can see in the plots that traces for all elements of Rat and X
## are well-mixed. This run was saved in "bceOutput"

Sum <-summary(bceOutput)

# show results as mean with ranges
print(Sum$meanX)

# plot estimated means and ranges (lbX=lower, ubX=upper bound)
xlim <- range(c(Sum$lbX,Sum$ubX))

# first the mean
dotchart(x=t(Sum$meanX),xlim=xlim,                                                          
         main="Taxonomic composition",
         sub="using bce",pch=16)

# then ranges
nr <- nrow(Sum$meanX)
nc <- ncol(Sum$meanX)

for (i in 1:nr) 
{ip <-(nr-i)*(nc+2)+1
 cc <- ip : (ip+nc-1)
 segments(t(Sum$lbX[i,]),cc,t(Sum$ubX[i,]),cc)
 }

# show results as pairs plot
pairs(bceOutput,sample=3,main="Station 3")

}
\author{Karel Van den Meersche <k.vdmeersche@nioo.knaw.nl>, Karline Soetaert <k.soetaert@nioo.knaw.nl>}
\keyword{models}

