% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/util.R
\name{shadeArea}
\alias{shadeArea}
\title{Plot a curve with a shaded area.}
\usage{
shadeArea(fun, xlim, shade.from = xlim[1], shade.to = xlim[2],
  length = 1000, curve.col = "blue", shade.col = "gray",
  shade.border = NA, draw.curve = TRUE, add = FALSE, ...)
}
\arguments{
\item{fun}{function}

\item{xlim}{min and max X value to plot the curve}

\item{shade.border}{Border color. By default the border is not drawed (NA), to let the initial curve unchanged.}

\item{draw.curve}{= TRUE If FALSE, only plot the shaded area}

\item{...}{Additional parameters are passed to fun via lapply}

\item{shade.from=xlim[1]}{min X value for the shaded area}

\item{shade.to=xlim[2]}{max X value for the shaded area}

\item{length=1000}{number of points for the polygon}

\item{shade.col="gray"}{Shading color, passed to polygon()}

\item{add=FALSE}{Add the shaded area to existing plot}
}
\description{
Plot the curve for a given function, and shade the area 
below it between two given limits.
}
\details{
First version: 2015-03
Last modification: 2015-03
}
\examples{

## Shade the interval (-1,1) below Student density function
z <- 3.5
shadeArea(dt, xlim=c(-5,+5), shade.from=-1, shade.to=1, df=4, curve.col="darkred", shade.col="#DDBBEE", shade.border="red")

}
\author{
Jacques van Helden (\email{Jacques.van-Helden@univ-amu.fr})
}

