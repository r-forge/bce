
library("cemeLabs")

filename <- "273439.csv"

qty_standard <- 0.02
qty_sample <- 1
volume_chlor <- 20
weight_chlor <- 15
int_standard <- 2
int_ecl <- 0.02
minarea <- 0  


irms(filename,
  irms.ref = irms.bpx70,
  time_standard = c(956,1752.9,2351.7),
  ecl_standard = c(12,16,19),
  qty_standard,
  qty_sample,
  volume_chlor,
  weight_chlor,
  int_standard,
  int_ecl,
  minarea  
)

