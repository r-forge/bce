
# ==============================================================================
# correct equivalent chain lenghts based on standard retention times
# ==============================================================================

correctecl <- function(data,stdtimes,stdecl){

  peaknumber <- nrow(data)
  stdnumber <- length(stdtimes)
  newecl <- rep(0,peaknumber)

  for(i in 1:peaknumber){
    for(j in 1:(stdnumber-1)){
      if(data$time[i] < stdtimes[j] & j == 1) {
        newecl[i] <- stdecl[j] + (stdecl[j+1]-stdecl[j]) *
        ((data$time[i]-stdtimes[j])/(stdtimes[j+1]-stdtimes[j]))
      }
      if(data$time[i] >= stdtimes[j] & data$time[i] <= stdtimes[j+1]) {
        newecl[i] <- stdecl[j] + (stdecl[j+1]-stdecl[j]) *
        ((data$time[i]-stdtimes[j])/(stdtimes[j+1]-stdtimes[j]))
      }
      if(data$time[i] >= stdtimes[j+1] & j == (stdnumber-1)) {
        newecl[i] <- stdecl[j] + (stdecl[j+1]-stdecl[j]) *
        ((data$time[i]-stdtimes[j])/(stdtimes[j+1]-stdtimes[j]))

      }
    }
  }
  return(newecl)
}

# ==============================================================================
# identify the peaks
# ==============================================================================


idpeaks <- function(data,fa,interv){

  peaknumber <- nrow(data)
  newname <- rep("",peaknumber)
  fanumber <- nrow(fa)

  serror <- FALSE
  for(i in 1:peaknumber) {
    distance <- abs(fa$ecl-data$ecl[i])
    goodpeaks <- match(subset(distance,distance<interv),distance)
    numpeaks <- length(goodpeaks)
    if (numpeaks == 0) {
      closest <- match(min(distance),distance)
      newname[i] <- paste("UNKNOWN ",fa$name[closest]," (",
        fa$ecl[closest],",",round(min(distance),digits=3),")",sep="")
        serror <- TRUE
    }
    if(numpeaks == 1){
      newname[i] <- as.character(fa$name[goodpeaks])
    }
    if(numpeaks > 1){
      outstr <- NULL
      for(good in goodpeaks) {
        outstr <- paste(outstr,as.character(fa$name[good])," (",fa$ecl[good],",",
          round(distance[good],digits=3),"), ",collapse="",sep="")
      }
      outstr <- substr(outstr,1,nchar(outstr)-2)
      newname[i] <- paste("MULTIPLE ",outstr,sep="")
      serror <- TRUE

    }
  }
  if (serror) warning (" some peaks are unknown - run edit or plfa.accept on the input")
  return(newname)
}


# ==============================================================================
# get retention times of the standard
# ==============================================================================


getstdtimes <- function(data,stdtimes,interv) {
  result <- NULL

  for(stdtime in stdtimes) {
    cand <- subset(data,data$time>=stdtime-interv &
                        data$time<=stdtime+interv)
    candnum <- nrow(cand)
    if(candnum > 0){
      result <- c(result,cand$time[1])
    } else {
      result <- c(result,0)
      cat("ERROR: no candidate for standard at ",stdtime,"\n",sep="")
    }
    if(candnum > 1) {
      cat("ERROR: multiple candidates for standard at ",stdtime,"\n",sep="")
    }
  }
  return(result)
}

# ==============================================================================
# find double peaks
# ==============================================================================

doublepeaks <- function(data, int_ecl){

  peaknumber <- nrow(data)

  for(p1 in 1:peaknumber){
    for(p2 in 1:peaknumber){
      if(p1 < p2){
        if(abs(data$ecl[p1]-data$ecl[p2]) <= int_ecl)
          cat("WARNING double peak ",p1,", ",p2,"\n",sep="")
      }
    }
  }
}

# ==============================================================================
# chromatogram function:
# ==============================================================================
chromatogram <- function(input, fa,
                  time_standard,
                  ecl_standard,
                  qty_standard, qty_sample,
                  volume_chlor, weight_chlor,
                  int_standard,
                  int_ecl)   {

  name_standard <- paste ("c",ecl_standard,sep="")
  standardname  <- "C19:0"

  chlordensity  <- 1.47

  standards <- getstdtimes(input,time_standard,int_standard)

  # correct ecl using standard
  input <- cbind(input,ecl = correctecl(input,standards,ecl_standard))

  # identify peaks and calculate concentration
  newname <- idpeaks(input,fa,int_standard)
  input <- cbind(input,name = newname)

  standardarea <- input$area[input$name==standardname]
  concentration <- ((input$area/standardarea)*qty_standard)*
     ((weight_chlor/chlordensity)/volume_chlor)/qty_sample
  percentage <- concentration / sum(concentration) * 100

  input <- cbind(input,concentration,percentage)
  doublepeaks(input, int_ecl)
  class(input) <- c("chrom","data.frame")
  input
}
