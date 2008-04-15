\name{export.bce}
\alias{export.bce}
\title{export BCE}
\description{export function: writes a BCE-object and its summary statistics to a file}
\usage{export.bce(BCE, filename="BCE", input.list=NULL, path="out")}
\arguments{
  \item{BCE }{a bce object, output of the function bce()}
  \item{filename }{filename of the exported file}
  \item{input.list }{a list of the arguments in bce() can be provided and saved as well.}
  \item{path }{path to where the files have to be saved; if absent, it will be created. Default to a folder "out" in the current working directory}
}
\author{Karel Van den Meersche}
\keyword{IO}

