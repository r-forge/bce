# Local function

  readfa <- function(filename, minarea=0) {

    data <- read.csv(filename,header=TRUE,sep=";",
                   as.is=TRUE,strip.white=TRUE)

    if (ncol(data) != 8)
      data <- read.csv(filename,header=TRUE,
               as.is=TRUE,strip.white=TRUE)

    if (ncol(data) != 8)
      stop("error in readdata: should be in csv format, separated with ';' or ',' and 8 columns")

    names(data) <- c("number","time","height","area","Name",
                   "widthat50","originalconc","solutionconc")
    data <- subset(data,data$area>=minarea)

    return(data)
  }

# ==============================================================================
# main plfa function:
# ==============================================================================

plfa <- function (input, fa.ref = fa.bpx70,
                  time_standard = c(17.045,31.155,41.288),
                  ecl_standard = c(12,16,19),
                  qty_standard, qty_sample = 1,
                  volume_chlor, weight_chlor,
                  int_standard = 0.02,
                  int_ecl = int_standard,
                  minarea = 0)

{


 # read data
  if (is.null (fa.ref)) {
    faname <- "bpx"
    fa.ref <- fa.bpx70
  }
  else if (is.character(fa.ref)) {
    faname <- fa.ref
    fa.ref <- read.csv(fa.ref,header=TRUE,sep=";",as.is=TRUE)
  } else faname <- "other"  # KARLINE: CHANGE THIS...

  if (is.character(input)) {
    inputname <- input
    input <- readfa(input, minarea)
  } else inputname <- "data.frame"
  input <- chromatogram(input, fa.ref, time_standard, ecl_standard,
    qty_standard, qty_sample, volume_chlor, weight_chlor,
    int_standard, int_ecl)

  attr(input,"type") <- "fame"
  attr(input,"standard") <- data.frame(
                  time_standard=time_standard,
                  ecl_standard = ecl_standard
                  )
  attr(input,"input") <- data.frame(input=inputname,
                  standard = faname,
                  qty_standard = qty_standard, qty_sample = qty_sample,
                  volume_chlor = volume_chlor, weight_chlor = weight_chlor,
                  int_standard = int_standard,
                  int_ecl = int_ecl, minarea = minarea)

  input
}


# ==============================================================================
# S3 methods
# ==============================================================================

## - plot chromatogram

plot.chrom <- function(x,...) {
  chrom.plot(x, xvar="ecl", label="name", ...)
}


# ==============================================================================
## edit chromatogram

edit.chrom <- function(name, ...) {
  NN <- edit(as.data.frame(name[,9:12]),...)
  name[,9:12]<-NN
#   class(name) <- c("chrom","data.frame")
  name
}


diagnostics <- function(x) {
  ATT <- attributes(x)
  if (any(is.na(ATT$standard)))
    stop("cannot print diagnostic information: not a chromatogram")
  cat("standards\n")
  print(ATT$standard)
  cat("\n input\n")
  print(data.frame(value=t(ATT$input)))
}
