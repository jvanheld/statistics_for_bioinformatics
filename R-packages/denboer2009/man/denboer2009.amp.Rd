\name{denboer2009.amp}
\alias{denboer2009.amp}
\docType{data}
\title{Absent/Marginal/Present (APM) matrix for Den Boer 2009 dataset GSE13425}
\description{A data frame containing the Absent/Marginal/Present (APM) calls for the expression profiles from Den Boer 2009. The data was downloaded from Gene Expression Omnibus (GEO ID: GSE13425).}
\usage{data("denboer2009.amp")}
\format{A data frame with 22283 rows (probesets) on 190 columns (samples).}
\details{
}
\source{http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425}
\references{Den Boer, M.L., van Slegtenhorst, M., De Menezes, R.X., Cheok, M.H., Buijs-Gladdines, J.G.C.A.M., Peters, S.T.C.J.M., Van Zutven, L.J.C.M., Beverloo, H.B., Van der Spek, P.J., Escherich, G., et al. (2009) A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol, 10, 125–134.}
\examples{
data(denboer2009.amp)
data(denboer2009.expr)

## Check the dimensions of the ampession matrix
dim(denboer2009.amp)

## Associate a color to each label
call.colors=c("A"="red", "M"="yellow", "P"="green")

## Count the A/M/P calls per probeset
calls.per.probeset <- data.frame("A"=apply(denboer2009.amp=="A", 1, sum),
                                 "M"=apply(denboer2009.amp=="M", 1, sum),
                                 "P"=apply(denboer2009.amp=="P", 1, sum))
head(calls.per.probeset, n=20)

## Count the total numbers of Absent / Marginal / Present calls
barplot(table(as.vector(as.matrix(denboer2009.amp))), col=call.colors)

## Display histograms with the number of Absent / Marginal / Present calls per probeset (gene)
par(mfrow=c(3,1))
for (label in c("A", "M", "P")) {
  hist(apply(denboer2009.amp == label, 1, sum),
       breaks=0:ncol(denboer2009.amp), col=call.colors[label],
       xlab="Number of calls per probeset",
       ylab="Number of probesets",
       main=paste(label, "calls per probeset"))
}
par(mfrow=c(1,1))


## Display histograms of expression values per label
par(mfrow=c(3,1))
for (label in c("A", "M", "P")) {
  hist(as.vector(as.matrix(denboer2009.expr[denboer2009.amp==label])),
       breaks=100, col=call.colors[label],
       xlab="Level of expression",
       ylab="Number of probesets",
       main=paste(label, "calls"))
}
par(mfrow=c(1,1))


}
\keyword{datasets}

