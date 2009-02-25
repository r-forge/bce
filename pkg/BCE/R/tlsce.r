################################################################
## Total Least Squares Composition Estimator
## use optim() and lsei() to find (A+e)X=B+e with min. sum(e^2)
## this is an orthogonal alternative to chemtax
################################################################

tlsce <- function(A,B,
                  Wa=NULL,#Wb=NULL,               # weight matrices for A and B, weighted according to 1/stdev
                  optimizationfunction="nlminb",  # one of "optim","nlm","constrOptim"
                  A_init=A,                       # initial settings for elements of A in the optimization routine; to check convergence from different starting points.
                  Xratios=TRUE,                   # the columns sums of X have to be 1 (only if A and B are both expressed relative to the unit of biomass)
                                                  # if Xratios =TRUE, A has pigment concentrations per biomass unit, B has pigment concentrations per biomass unit per sample, and X contains ratios of biomass unit per sample.
                                                  # if Xratios =FALSE, A has pigment concentrations per biomass unit, B has pigment concentrations per sample, and X has biomass units per sample
                  ...)                            # settings for optimizationfunction
  {
    if (is.vector(B)) B <- as.matrix(B)
    
    l <- nrow(A)                        # number of pigments
    m <- ncol(A)                        # number of species
    n <- NCOL(B)                        # number of samples
    w <- which(A>0)
    lw <- length(w)
    A_c <- A[w]                         # non-zero elements of A
    if (Xratios) {E <- t(rep(1,m)); F <- t(rep(1,n))} else {E <- F <- NULL} # sum of species fractions is 1
    G <- diag(1,m); H <- matrix(0,m,n)  # all elements positive
    if(is.null(Wa))                     # weighting of elements of A
      {Wa_c <- rep(1,lw)
     }else{Wa_c <- Wa[w]}
    A_c_init <- A_init[w]

    sns <- function(A_c_new)             # function to minimize
      {
        sA <- sum(((A_c-A_c_new)*Wa_c)^2)
        A_new <- A; A_new[w] <- A_c_new
        sB <- LSEI(A_new,B,E,F,G,H)$solutionNorm
        return(c(sA,sB))
      }
    sn <- function(A_c_new) sum(sns(A_c_new))
        

    ## minimize sn
    if (optimizationfunction=="optim")
      opt <- optim(A_c_init,sn,method="L-BFGS-B",lower=0,...)
    if (optimizationfunction=="nlminb")
      opt <- nlminb(A_c_init,sn,lower=0,...)
    if (optimizationfunction=="constrOptim")
      opt <- constrOptim(A_c_init,sn,ui=diag(lw),ci=rep(0,lw),...)

    A_c_fit <- opt$par
    A_fit <- A; A_fit[w] <- A_c_fit
    X <- LSEI(A_fit,B,E,F,G,H)$X; rownames(X) <- colnames(A); colnames(X) <- colnames(B)
    B_fit <- A_fit%*%X
    solutionNorms <- sns(A_c_fit); solutionNorms <- c(sum(solutionNorms),solutionNorms); names(solutionNorms) <- c("total","A","B")

    return(list(X=X,A_fit=A_fit,B_fit=B_fit,solutionNorms=solutionNorms,convergence=opt$convergence))
  }

##############################################################
## helper functions
##############################################################

LSEI <- function(A=NULL,B=NULL,E=NULL,F=NULL,G=NULL,H=NULL,...)
  {
    if (is.vector(B)) return(lsei(A,B,E,F,G,H,...))
    else
      {
        X <- matrix(NA,ncol(A),ncol(B))
        solutionNorm <- 0
        for (i in 1:ncol(B))
          {
            BnotNA <- !is.na(B[,i])  # remove NA from B
            ls <- lsei(A[BnotNA,],B[BnotNA,i],E,F[,i],G,H[,i],...)
            X[,i] <- ls$X
            solutionNorm <- solutionNorm + ls$solutionNorm
          }
        return(list(X=X,solutionNorm=solutionNorm))
      }
  } # LSEI

