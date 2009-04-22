
# ==============================================================================
# plot a chromatogram
# ==============================================================================
plotchrom <- function(x, xvar="time", yvar="area", label="Name", marker = NULL,
          writelabels =FALSE, ...) {

  i <- match(xvar,names(x))
  if (is.na(i)) stop ("cannot plot chromatogram; xvar not present in input")
  X <- x[,i[1]]

  i <- match(yvar,names(x))
  if (is.na(i)) stop ("cannot plot chromatogram; yvar not present in input")
  Y <- x[,i[1]]

  ylim <- range(Y)
  if (writelabels) ylim[2] <- ylim[2]*1.2
  Col <- rep(1,length(X))
  if (writelabels ) {
    i <- match(label,names(x))
    if (is.na(i)) stop ("cannot plot chromatogram; label not present in input")
    lab <- x[,i]
    if (! is.null(marker)) {
        lev <- levels(marker$group)
        for (i in 1:length(lev)) {
          ii <- which (lev[i] == marker$group)
          names <- marker$name[ii]
          ij <- which (lab %in% names)
          Col[ij] <- i+1
        }
     }
  }
  plot(X, Y,type="h", ylim= ylim, col=Col,...)
  if (writelabels) {
    text(x=X,y=Y*1.01,labels= lab,srt=90, cex=0.7, adj=0)
  }
  if (! is.null(marker))
    legend("topleft",legend=lev,lwd=2,col=2:(length(lev)+1))
}
