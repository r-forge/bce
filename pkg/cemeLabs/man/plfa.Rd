\name{plfa}
\alias{plfa}
\alias{irms}
\alias{plot.chrom}
\alias{edit.chrom}
\alias{diagnostics}
\title{
  Analysing fatty acid chromatography data
}
\description{
  Analyses of fatty acid data obtained either

  by gas chromatography with flame ionization detection
  (GC-FID carlo erba HRGC mega 2 GC) (function \code{plfa})
  
  or by
  
  gas-chromatograph combustion interface isotope-ratio mass spectrometer
  (GC-c-IRMS) \code{irms}
  
  Input is a csv data file, as generated from the excel file returned
  by the instrument
  
  Output is the data with the peaks identified and the concentration calculated.
}

\usage{
plfa(input, fa.ref = fa.bpx70,
  time_standard = c(17.045,31.155,41.288),
  ecl_standard = c(12,16,19), qty_standard,
  qty_sample = 1, volume_chlor, weight_chlor,
  int_standard = 0.02, int_ecl = int_standard, minarea = 0)

irms(input, irms.ref = irms.bpx70,
  time_standard = c(879.4000244,1654.3,2248.1),
  ecl_standard = c(12,16,19), qty_standard,
  qty_sample = 1, volume_chlor, weight_chlor,
  int_standard = 0.02, int_ecl = int_standard, minarea = 0)

diagnostics(x)

\method{plot}{chrom}(x, \dots)

\method{edit}{chrom}(name, \dots)

}
\arguments{
  \item{input }{input data, either the name of a \emph{csv} file,
    a data file with the metadata removed or a data.frame with the
    following columns: number, time, height, area, name,
    widthat50, originalconc, solutionconc)
  }
  \item{fa.ref }{reference fatty acid data, corresponding to the analytical
    column used by the GC-FID,
    one of \code{fa.bpx70}, \code{fa.zb5}, \code{fa.apolar}, \code{fa.polar1},
    or \code{fa.polar2}. See \link{fa.columns} for more information about
    these columns.
  
    Alternatively, it is possible to provide (1) the name of a \emph{csv} file,
    (including the path) of input data, or (2) a \emph{data.frame} with
    two columns: the equivalent chain length (1st column) and the name of
    the plfa.

    if \code{NULL} then the bpx70 column is assumed (see \link{fa.bpx70})
  }
  \item{irms.ref }{reference fatty acid data, corresponding to the analytical
    column used by the GC-c-IRMS. For now only \code{irms.bpx70}.
    See \link{fa.columns} for more information about these columns.

    Alternatively, it is possible to provide (1) the name of a \emph{csv} file,
    (including the path) of input data, or (2) a \emph{data.frame} with
    two columns: the equivalent chain length (1st column) and the name of
    the plfa.

    if \code{NULL} then the bpx70 column is assumed (see \link{irms.bpx70})
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
  \item{minarea }{minimal area below which the peaks are ignored
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
      \code{chrom.plot}. See \link{chrom.plot} for available options.
    }
    \item{edit}{ Allows to edit the resulting data.frame. Use this when
      the function issued a warning that some peaks could not be discerned,
      or there were double peaks.

      In this case use:

      \code{PLFA <- edit(PLFA)}
      
      where \code{PLFA} results from running function \code{plfa}
    }
  }
  Function \code{diagnostics} prints the input values of the chromatograms
}
\examples{
  PLFA <- plfa(input=fa.data, qty_standard=2.01,
               volume_chlor = 15, weight_chlor=20)
  plot(PLFA, xlab="ECL", ylab="peak area", main="plfa dataset",
       writelabels=TRUE)
  diagnostics(PLFA)
}

\keyword{utilities}

