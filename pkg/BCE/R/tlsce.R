################################################################
## Total Least Squares Composition Estimator
## use modFit
## this is an orthogonal alternative to chemtax
## Wb added (is called Wa in lsei...)
## is tested with all 4 examples (bce-tests.r) and performs
## as well or better than the previous tlsce.
## the use of modFit also allows for more flexibility in tuning
## the optimization algorithm, and more output details (hessian,...)
################################################################

tlsce <- function(A,B,
                  Wa=NULL,
                  Wb=NULL,     # weight matrices for A and B, weighted
                               # according to 1/stdev
                  minA=NULL,
                  maxA=NULL,
                  A_init=A,    # initial settings for elements of A in
                               # the optimization routine; to check
                               # convergence from different starting
                               # points.
                  Xratios=TRUE,# the columns sums of X have to be 1
                               # (only if A and B are both expressed
                               # relative to the unit of biomass) if
                               # Xratios =TRUE, A has pigment
                               # concentrations per biomass unit, B
                               # has pigment concentrations per
                               # biomass unit per sample, and X
                               # contains ratios of biomass unit per
                               # sample.  if Xratios =FALSE, A has
                               # pigment concentrations per biomass
                               # unit, B has pigment concentrations
                               # per sample, and X has biomass units
                               # per sample
                  ...)         # parameters to be passed on to lsei()
                               # or to modFit()
  {

    ##=================##
    ## initialisations ##
    ##=================##
    
    if (is.vector(B)) B <- as.matrix(B)
    
    l <- nrow(A)                        # number of pigments
    m <- ncol(A)                        # number of species
    n <- NCOL(B)                        # number of samples
    w <- which(A>0)
    lw <- length(w)
    A_c <- A[w]                         # non-zero elements of A
    if (Xratios) {
      E <- t(rep(1,m)); F <- t(rep(1,n))} else {
        E <- t(rep(0,m)); F <- t(rep(0,n))} # sum of species fractions is 1 or not
    G <- diag(1,m); H <- matrix(0,m,n)  # all elements positive
    if(is.null(Wa))                     # weighting of elements of A
      {Wa_c <- rep(1,lw)
     }else{Wa_c <- Wa[w]}
    A_c_init <- A_init[w]
    if (is.null(minA)) minA_c <- rep(0,lw) else minA_c <- minA[w]
    if (is.null(maxA)) maxA_c <- rep(+Inf,lw) else maxA_c <- maxA[w]
    residuals <- function(A_c_new)
      {
        A_new <- A
        A_new[w] <- A_c_new
        X <- LSEI(A_new,B,E,F,G,H,Wa=Wb)$X
        if (is.null(Wb)) return(c(Wa_c*(A_c-A_c_new),A_new%*%X-B))
        return(c(Wa_c*(A_c-A_c_new),Wb*(A_new%*%X-B)))
      }

    
    ##===========##
    ## model fit ##
    ##===========##
    
    tlsce_fit <- modFit(residuals,A_c,lower=minA_c,upper=maxA_c,...)

    
    ##========##
    ## output ##
    ##========##
    
    A_c_fit <- tlsce_fit$par
    A_fit <- A; A_fit[w] <- A_c_fit
    LSEI_fit <- LSEI(A_fit,B,E,F,G,H,Wa=Wb)
    X <- LSEI_fit$X; rownames(X) <- colnames(A); colnames(X) <- colnames(B)
    B_fit <- A_fit%*%X
    ssr <- tlsce_fit$ssr
    ssr_B <- LSEI_fit$solutionNorm
    ssr_A <- ssr-ssr_B
    solutionNorms <- c(ssr,ssr_A,ssr_B); names(solutionNorms) <- c("total","A","B")

    return(list(X=X,
                A_fit=A_fit,
                B_fit=B_fit,    # the fits
                SS=solutionNorms, # residual sums of squares
                fit=tlsce_fit)) # a modFit object
  }


##############################################################
## helper functions
##############################################################


LSEI <- function(A=NULL,B=NULL,E=NULL,F=NULL,G=NULL,H=NULL,Wa=NULL,...)
  {
    if (is.vector(B)) return(lsei(A,B,E,F,G,H,Wa=Wa,...))
    else
      {
        X <- matrix(NA,ncol(A),ncol(B))
        solutionNorm <- 0
        for (i in 1:ncol(B))
          {
            BnotNA <- !is.na(B[,i])  # remove NA from B
            ls <- lsei(A[BnotNA,],B[BnotNA,i],E,F[,i],G,H[,i],Wa=Wa[BnotNA,i],...)
            X[,i] <- ls$X
            solutionNorm <- solutionNorm + ls$solutionNorm
          }
        return(list(X=X,solutionNorm=solutionNorm))
      }
  } # LSEI


## LSEI <- function(A=NULL,B=NULL,E=NULL,F=NULL,G=NULL,H=NULL,Wa=NULL,...)
##   {
##     if (is.vector(B)) B <- as.matrix(B)

##     X <- matrix(NA,ncol(A),ncol(B))
##     solutionNorm <- 0
##     for (j in 1:ncol(B))
##       {
        
##         BnotNA <- !is.na(B[,j])  # remove NA from B (missing data)
##         Xpresent <- colSums(subset(A,B[,j]==0))==0  # remove missing groups from A (biomarker not found)
##         X[!Xpresent,j] <- 0
##         ls <- lsei(A[BnotNA,Xpresent],B[BnotNA,j],E[,Xpresent],F[,j],G[,Xpresent],H[,j],Wa=Wa[BnotNA,j],...)
##         X[Xpresent,j] <- ls$X
##         solutionNorm <- solutionNorm + ls$solutionNorm
##       }
##     return(list(X=X,solutionNorm=solutionNorm))
##   } # LSEI

