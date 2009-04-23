# ==============================================================================
# Accepts the defaults suggested for the chromatogram
# ==============================================================================

chrom.accept <- function (chrom) {
  ii <- c(grep ("UNKNOWN",chrom$name), grep("MULTIPLE",chrom$name))
  if (length(ii) > 0) {
    chrom$name <- as.character(chrom$name)
    chrom$name[ii] <- as.character(chrom$Name[ii])
    chrom$name<-factor(chrom$name)
  }
  chrom
}
