\name{bce}
\alias{bce}
\title{Bayesian Composition Estimator}
\description{
  estimates probability distributions of a sample composition
  based on an \bold{input ratio matrix}, \code{A}, containing
  biomarker ratios in (field) samples, and an \bold{input data matrix},
  \code{B}, containing the biomarker ratios for several taxonomic groups.
  
  Probability distributions are estimated based on an adaptive metropolis
  MCMC method, function \code{modMCMC} from package \code{FME}.
}
\usage{bce(A, B, Wa=NULL, Wb=NULL,
       jmpType="default", jmpA=.1,jmpX=.1, jmpCovar=NULL,
       initX=NULL, initA=NULL, priorA="normal", minA=NULL, maxA=NULL, 
       var0=NULL, wvar0=1, Xratios=TRUE, verbose=TRUE, ...)
}
\arguments{
  \item{A }{input (group) ratio matrix; can be a matrix or a dataframe
  }
  \item{B }{input (field) data matrix; can be a matrix or a  dataframe
  }
  \item{Wa }{elementwise weight matrix for A, with the
    same dimensions as A. \deqn{[Wa*(A-A_0)]^2} is minimized
  }
  \item{Wb }{elementwise weight matrix for B, with the same dimensions
    as B. \deqn{[Wb*(A\%*\%X-B)]^2} is minimized
  }
  \item{jmpType }{one of "default", "estimate" or "covar"; if default, jmpA and jmpX
    are the jump lengths. if jmpA or jmpX is a number,
    then this is the jump length for all elements of A
    resp. X. If "estimate", the initial jump length is
    proportional to an estimated covariance matrix for the
    tlsce fit for A and the lsei fit of X (or Q if
    Xratios). jmpA and jmpX are then used as rescaling
    factors for jump covariance matrix. If "covar", a jump
    covariance matrix with the correct dimensions, obtained
    from a previous run, is given as parameter jmpCovar.
    Covariances can be calculated from the result. 
  }
  \item{jmpA }{jump length of A: a number or a matrix with dim(A); see
    details jmpType
  }
  \item{jmpX }{jump lenth of X: a number or a matrix with dim(X); see
    details jmpType
  }
  \item{jmpCovar }{only if jmpType="covar", the covariance matrix to
    initiate the jumps - see details jmpType
  }
  \item{initX }{composition matrix used to start the markov chain:
      default the tlsce solution of Ax=B
  }
  \item{initA }{ratio matrix used to start the markov chain:
      default the input ratio matrix A
  }
  \item{priorA }{"normal" (gaussian - default) or "uniform"
  }
  \item{minA }{minimum values for A
  }
  \item{maxA }{maximum values for A
  }
  \item{var0 }{initial model variance; if 'NULL', then the model
      variance of tlsce(A,B,...) is used
  }
  \item{wvar0 }{relative weight of the initial model variance
    (see modMCMC)
  }
  \item{Xratios }{does the composition matrix contain ratios (TRUE) or
      estimated biomass concentrations (TRUE) per sample? In the
      latter case, B must contain the pigment concentrations as
      measured in the samples (not rescaled)
  }
  \item{verbose }{when \code{TRUE} will give more verbose output
  }
  \item{... }{arguments to pass on to modMCMC()
  }
}
\details{
  The function \code{bce} searches probability distributions for all
  elements of a taxonomical composition matrix \code{X} and a ratio
  matrix \code{A} for which:

  \deqn{A\%*\%X \simeq B}{A\%*\%X ~= B}
  
  It does this by returning \code{niter} samples for A and X, organized
  in three-dimensional arrays. The input
  data matrix \code{B} and ratio matrix \code{A} should be
  in the following formats, with the relative concentrations per
  biomarker organized in columns:

  data matrix B:
  \tabular{ccccc}{
    \tab  sample1 \tab  sample2 \tab  sample3 \tab  sample4  \cr
    marker1  \tab  0.14 \tab  0.005  \tab  0.35	 \tab	0.033  \cr
    marker2  \tab  0.15	\tab  0.004  \tab  0.36	 \tab	0.034  \cr
    marker3  \tab  0.13	\tab  0.004  \tab  0.31  \tab	0.030  \cr
    marker4  \tab  0.13	\tab  0.005  \tab  0.33	 \tab	0.031  \cr
    marker5  \tab  0.14	\tab  0.008  \tab  0.33  \tab	0.036  \cr
    marker6  \tab  0.11	\tab  0.082  \tab  0.34  \tab	0.044
  }

  and ratio matrix A:
  \tabular{ccccc}{
    \tab  species1  \tab  species2 \tab	species3	\tab	species4	\cr
    marker1  \tab  0.27     \tab  0.13	   \tab	0.35	\tab	0.076	\cr
    marker2  \tab  0.084    \tab  0	   \tab	0.5	\tab	0.24	\cr
    marker3  \tab  0.195    \tab  0.3	   \tab	0	\tab	0.1	\cr
    marker4  \tab  0.06     \tab  0	   \tab	0	\tab	0	\cr
    marker5  \tab  0	     \tab  0	   \tab	0	\tab	0	\cr
    marker6  \tab  0	     \tab  0	   \tab	0	\tab	0
  }
}

\value{
  An object of class bce and _modMCMC_ (returned by the function
  modMCMC). This object has methods for the generic
  functions 'summary', 'plot', 'pairs'- see ?modMCMC.
  It is distinguished from other modMCMC objects by 3 extra attributes
  that allow to extract matrices A and X from the mcmc result: "dim_A"
  (dimensions of A), "A_not_null" (which elements of A are not zero and
  thus included in the mcmc) and Xratios (whether X was rescaled, yes or
  no). 
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
\author{Karel Van den Meersche <k.vdmeersche@nioo.knaw.nl>,
  Karline Soetaert <k.soetaert@nioo.knaw.nl>.
}
\keyword{models}

