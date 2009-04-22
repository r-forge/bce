# ==============================================================================
# Accepts the defaults suggested by the plfa function
# ==============================================================================

plfa.accept <- function (PLFA) {
  ii <- c(grep ("UNKNOWN",PLFA$name), grep("MULTIPLE",PLFA$name))
  if (length(ii) > 0) {
    PLFA$name <- as.character(PLFA$name)
    PLFA$name[ii] <- as.character(PLFA$Name[ii])
    PLFA$name<-factor(PLFA$name)
  }
  PLFA
}
