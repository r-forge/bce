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
confInt = 2/3, export = FALSE, filename = "BCE")}
\arguments{
  \item{Rat }{initial ratio matrix. Each row of \code{Rat} contains the biomarker composition
  of one taxon. As a result of the Bayesian procedure, this initial ratio matrix will be altered
   }
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
  \item{positive }{A vector containing numbers of columns that should contain strictly positive data. 
Only these columns are rescaled. The other columns (not in \code{positive} are not rescaled, and can become negative}
  \item{iter }{number of iterations for MCMC}
  \item{outputlength }{number of iterations kept in the output}
  \item{burninlength }{number of initial iterations to be removed from output}
  \item{jmpRat }{jump length of the ratio matrix \code{Rat} (in normal space). 
Either a number, a vector with length equal to the number of biomarkers (number of columns in \code{Rat}), 
or a or matrix with the same dimensions as the ratio matrix \code{rat}}
  \item{jmpX }{jump length of the composition matrix (in a simplex). Either one number, a vector of length equal to the number of taxa (number of rows in \code{Rat})
 or a matrix with the same dimensions = c(number of taxa, number of field samples)}
  \item{unif }{logical; if TRUE a uniform distribution for ratio matrix is used. This is similar as in chemtax}
  \item{verbose }{logical; if TRUE, extra information is provided during the run of the function, such as extra warnings, 
elapsed time and expected time until the end of the MCMC }
  \item{initRat }{ratio matrix used to start the markov chain: defaults to the initial ratio matrix}
  \item{initX }{composition matrix used to start the markov chain: default the LSEI solution of Ax=B}
  \item{userProb }{posterior probability for a given ratio matrix and composition matrix: 
should be a function with 2 arguments RAT and X, and as returned value a number 
giving the -log posterior probability of ratio matrix RAT and composition matrix X. 
Dependence of the probability on the data should be incorporated in the function. If not specified,
the default probability distribution is the gamma function}
  \item{confInt }{confidence interval in output; because the distributions may not be symmetrical, 
standard deviations are not always a useful measure; instead, upper and lower boundaries of the given confidence interval are given. 
Default is 2/3, i.e there is a probability of 0.66 for a value to be contained within the interval.}
  \item{export }{logical; if \code{TRUE}, a list of variables and plots are exported to the specified \code{filename}.}
  \item{filename }{Only if \code{export} is TRUE. If not NULL, a character string specifying the filename for saved objects. 
If NULL, the list is exported to the location indicated by the path. }
}
\value{
  A bce (bayesian compositional estimator) object; a list containing 4 elements
  \item{Rat }{ Array with dimension c(nrow(\code{Rat}),ncol(\code{Rat}),\code{iter}) containing the random walk values of the ratio matrix \code{Rat}}
  \item{X }{ Array with dimension c(nrow(\code{X}),ncol(\code{X}),\code{iter}) containing the random walk values of the composition matrix \code{X}}
  \item{p }{ vector with length \code{iter} containing the random walk values of the posterior probability}
  \item{naccepted }{ integer indicating the number of runs that were accepted}
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

## mixing is still a little poor.
## to optimize mixing in the ratio matrix, it is a good idea
## to make the jump length linear to the ratio matrix
## standard deviation (sdrat=.2*rat) :
X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
         iter=1000,outputlength=5000,jmpX=.02,
         jmpRat=.2*(.2*bceInput$Rat))
plot(X)

## set export=TRUE to write the result immediately to files.
## mixing improved a lot; we repeat the run with more iterations
## to improve the reliability of the results.
## the following run can take a few minutes - so it is toggled off
#X <- BCE(bceInput$Rat,bceInput$Dat,relsdRat=.2,relsdDat=.2,
#         iter=100000,outputlength=5000,jmpX=.02,
#         jmpRat=.2*(.2*bceInput$Rat))
#plot(X)
# This run was saved in "bceOutput"

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

