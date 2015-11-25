#' @title Draw a simple heatmap from a matrix, with values written in the cells.
#'
#' @author Jacques van Helden (\email{Jacques.van-Helden@@univ-amu.fr})
#' @description  Draw a simple heatmap from a matrix, without any clustering or 
#' fancy features, but with the values written in the cells. This is a simple way to circumvent 
#' several difficulties with the heatmap() and heatmap.2() functions, which 
#' generate beautiful maps with many intersting features, which I generally spend
#' a lot of time to disactivate. 
#'
#' @details
#' First version: 2015-10
#' Last modification: 2015-10
#'
#' @param x A matrix or data frame
#' @param main=NA Main title, passed to image()
#' @param xlab=NA Label for X axis, passed to image()
#' @param ylab=NA Label for Y axis, passed to image()
#' @param display.values=TRUE Display the values on the cell.
#' @param text.color="black" Color to write the values.
#' @param col=gray.colors(256, start=1, end=0) Color map. 
#' @param zlim=range(m) passed to image()
#' @param signif.digits=NA If specified, values are rounded with the function signif().
#' @param ...  Additional parameters are passed to the function image()
#' 
#' @return No return
#' @examples
#' ## Draw the heatmap of a Markov model of order 1 trained with the
#' ##  whole Human genome.
#' ## This example highlights the strong avoidance of the CpG dinucleottide.
#' org <- "Homo_sapiens_GRCh38"
#' m <- 1 ## Order of the Markov model
#' k <- m + 1 ## Length of oligomers used to estimate the parameters
#' transition.file <- system.file("extdata", 
#'   file.path("markov_models", org, 
#'       paste(sep="", k, "nt_genomic_", org, "-1str-ovlp_transitions.tab.gz")), 
#'       package = "stats4bioinfo")
#' markov.transitions <- read.delim(transition.file, comment=";", row.names=1)
#' # markov.transitions <- round(digits=2, as.matrix(markov.transitions))
#' heatmap.simple(markov.transitions[, c("a","c","g","t")], zlim=c(0,1),
#'    main=paste(org, "genomic Markov, order =", m), signif.digits=10,
#'    xlab="Suffix", ylab="Prefix")
#' @export
heatmap.simple <- function(x,
                           main=NA,
                           xlab=NA,
                           ylab=NA,
                           display.values=TRUE,
                           text.color="black",
                           col=gray.colors(256, start=1, end=0),
                           zlim=range(x, na.rm=TRUE),
                           signif.digits=NA,
                           ...) {
  x <- as.matrix(x[nrow(x):1,])
  if (!is.na(signif.digits)) {
    x <- signif(digits=signif.digits, x)
  }
  image(1:ncol(x), 1:nrow(x), t(x), 
        main=main,
        xlab=xlab,
        ylab=ylab,
        col=col,
        zlim=zlim,
        axes = FALSE, ...)
  axis(1, 1:ncol(x), colnames(x), tick=FALSE)
  axis(2, 1:nrow(x), rownames(x), las=2, tick=FALSE)
  if (display.values) {
    for (i in 1:ncol(x))
      for (j in 1:nrow(x))
        text(i, j, x[j,i], col=text.color)
  }
}