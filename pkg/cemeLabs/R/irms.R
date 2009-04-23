# ==============================================================================
# local functions: read irms data file
# ==============================================================================
readirms <- function(filename, minarea=0) {

  data <- read.csv(filename,header=TRUE,sep=";",
                   as.is=TRUE,strip.white=TRUE)

  if (ncol(data) != 41) # try a csv file separated with ,
    data <- read.csv(filename,header=TRUE,
               as.is=TRUE,strip.white=TRUE)

  if (ncol(data) != 41)
    stop("error in readirms: should be in csv format, separated with ; or , and 41 columns")

  data <- data[,c(2,3,7,16,35,38)]
  names(data) <- c("number","component","time","area","d13C","d18O")
  
# ALLnames <- c("filename","number","component","masterpeak","refname",
#     "start","time","end","width","ampl44","ampl45","ampl46","bgd44",
#     "bgd45","bgd46","area","area44","area45","area46","rareaall",
#     "rarea44","rarea45","rarea46","r45co244co2","rr45co244co2",
#     "rd45co244co2vsco2labtank","d45co244co2vsvpdbvsmow","deltadelta45co244co2",
#     "r46co244co2","rr46co244co2","rd46co244co2vsco2labtank",
#     "d46co244co2vsvpdbvsmow","deltadelta46co244co2","r13c12c",
#     "d13c12cvsvpdb","AT13c12c","R18o16o","d18o16ovsvsmow",
#     "AT18o16o","r17o16o","d17o16o")

  data <- subset(data,data$area>=minarea)
  return(data)

}


# ==============================================================================
# ==============================================================================
# main irms function:
# ==============================================================================
# ==============================================================================

irms <- function (input, irms.ref = irms.bpx70,
                  time_standard = c(879.4000244,1654.3,2248.1),
                  ecl_standard = c(12,16,19),
                  qty_standard, qty_sample = 1,
                  volume_chlor, weight_chlor,
                  int_standard = 0.02,
                  int_ecl = int_standard,
                  minarea = 0)
                  
                  
{
 # read data
  if (is.null (irms.ref))   {
    irms.ref <- irms.bpx70
    irmsname <- "bpx70"
    }
  else if (is.character(irms.ref)) {
    irmsname <- irms.ref
    irms.ref <- read.csv(irms,header=TRUE,sep=";",as.is=TRUE)
  }
  if (is.character(input))  {
    inputname <- input
    input <- readirms(input, minarea)
  } else inputname <- "data.frame"
  
  input <- chromatogram(input, irms.ref, time_standard, ecl_standard,
    qty_standard, qty_sample, volume_chlor, weight_chlor,
    int_standard, int_ecl)

  attr(input,"type") <- "irms"
  attr(input,"standard") <- data.frame(
                  time_standard=time_standard,
                  ecl_standard = ecl_standard
                  )
  attr(input,"input") <- data.frame(input=inputname,
                  standard = irmsname,
                  qty_standard = qty_standard, qty_sample = qty_sample,
                  volume_chlor = volume_chlor, weight_chlor = weight_chlor,
                  int_standard = int_standard,
                  int_ecl = int_ecl, minarea = minarea)

  input
}

