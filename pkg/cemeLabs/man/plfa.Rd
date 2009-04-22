\name{plfa}
\alias{plfa}
\alias{plot.chrom}
\alias{edit.chrom}
\title{
  Analysing fatty acid chromatography data
}
\description{
  Analyses of fatty acid data obtained by gas chromatography with flame
  ionization detection (GC-FID carlo erba HRGC mega 2 GC)
  
  Input is a csv data file, as returned from the instrument
  
  Output is the data with the peaks identified and the concentration calculated.
}

\usage{
plfa(input, fa = fa.bpx70, time_standard = c(17.045,31.155,41.288),
  ecl_standard = c(12,16,19), qty_standard,
  qty_sample = 1, volume_chlor, weight_chlor,
  int_standard = 0.02, int_ecl = int_standard)

\method{plot}{chrom}(x, \dots)

\method{edit}{chrom}(name, \dots)

}
\arguments{
  \item{input }{input data, either the name of a \emph{csv} file,
    a data file with the metadata removed or a data.frame with the
    following columns: number, time, height, area, name,
    widthat50, originalconc, solutionconc)
  }
  \item{fa }{input fatty acid data, corresponding to the column used,
   one of \code{fa.bpx70}, \code{fa.zb5}, \code{fa.apolar}, \code{fa.polar1},
   or \code{fa.polar2}. See \link{fa.columns} for more information about
   these columns.
  
   Alternatively, it is possible to provide (1) the name of a \emph{csv} file,
   (including the path) of input data, or (2) a \emph{data.frame} with
   two columns: the equivalent chain length (1st column) and the name of
   the plfa.

   if \code{NULL} then the bpx70 column is assumed (see \link{fa.bpx70})
  }
  \item{time_standard }{the retention times of the standard
  }
  \item{ecl_standard }{the standard equivalent chain length
  }
  \item{qty_standard }{the quantity of the standard
  }
  \item{qty_sample }{the quantity of the sample
  }
  \item{volume_chlor }{the volume chloroform added
  }
  \item{weight_chlor }{weight chloroform recovered
  }
  \item{int_standard }{the precision or interval in equivalent chain length units
    with which the standard peaks are distinguished
  }
  \item{int_ecl }{the precision or interval in equivalent chain length units
    with which the other peaks are distinguished
  }
  \item{x }{an object of class \code{chrom}.
  }
  \item{name }{an object of class \code{chrom}.
  }
  \item{...}{additional arguments passed to the methods.
  }
}
\details{
  The following methods are included:
  \describe{
    \item{plot}{ Plots the resulting chromatogram; it calls function
      \code{plotchrom}.  See \link{plotchrom} for availabel options.
    }
    \item{edit}{ Allows to edit the resulting data.frame. Use this when
      the function issued a warning that some peaks could not be discerned,
      or there were double peaks.

      In this case use:

      \code{PLFA <- edit(PLFA)}
      
      where \code{PLFA} results from running function \code{plfa}
    }
  }
}
\examples{
  PLFA <- plfa(input=fa.data, qty_standard=2.01,
               volume_chlor = 15, weight_chlor=20)
  plot(PLFA, xlab="ECL", ylab="peak area", main="plfa dataset",
       writelabels=TRUE)
}

\keyword{utilities}

