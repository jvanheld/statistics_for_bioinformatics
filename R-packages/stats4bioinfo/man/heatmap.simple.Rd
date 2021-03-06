% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/heatmap.simple.R
\name{heatmap.simple}
\alias{heatmap.simple}
\title{Draw a simple heatmap from a matrix, with values written in the cells.}
\usage{
heatmap.simple(x, main = NA, xlab = NA, ylab = NA,
  display.values = TRUE, text.color = "auto", col = gray.colors(256, start
  = 1, end = 0, gamma = 1), zlim = range(x, na.rm = TRUE),
  round.digits = NA, signif.digits = NA, ...)
}
\arguments{
\item{x}{A matrix or data frame}

\item{...}{Additional parameters are passed to the function image()}

\item{main=NA}{Main title, passed to image()}

\item{xlab=NA}{Label for X axis, passed to image()}

\item{ylab=NA}{Label for Y axis, passed to image()}

\item{display.values=TRUE}{Display the values on the cell.}

\item{text.color="black"}{Color to write the values.}

\item{col=gray.colors(256, }{start=1, end=0) Color map.}

\item{zlim=range(m)}{passed to image()}

\item{round.digits=NA}{If specified, values are rounded with the function round().}

\item{signif.digits=NA}{If specified, values are rounded with the function signif().}
}
\value{
No return
}
\description{
Draw a simple heatmap from a matrix, without any clustering or 
fancy features, but with the values written in the cells. This is a simple way to circumvent 
several difficulties with the heatmap() and heatmap.2() functions, which 
generate beautiful maps with many intersting features, which I generally spend
a lot of time to disactivate.
}
\details{
First version: 2015-10
Last modification: 2015-10
}
\examples{
## Draw the heatmap of a Markov model of order 1 trained with the
##  whole Human genome.
## This example highlights the strong avoidance of the CpG dinucleottide.
org <- "Homo_sapiens_GRCh38"
m <- 1 ## Order of the Markov model
k <- m + 1 ## Length of oligomers used to estimate the parameters
transition.file <- system.file("extdata", 
  file.path("markov_models", org, 
      paste(sep="", k, "nt_genomic_", org, "-1str-ovlp_transitions.tab.gz")), 
      package = "stats4bioinfo")
markov.transitions <- read.delim(transition.file, comment=";", row.names=1)
# markov.transitions <- round(digits=2, as.matrix(markov.transitions))
heatmap.simple(markov.transitions[, c("a","c","g","t")], zlim=c(0,1),
   main=paste(org, "genomic Markov, order =", m), signif.digits=10,
   xlab="Suffix", ylab="Prefix")
}
\author{
Jacques van Helden (\email{Jacques.van-Helden@univ-amu.fr})
}

