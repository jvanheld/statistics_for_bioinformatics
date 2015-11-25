\name{denboer2009.expr}
\alias{denboer2009.expr}
\docType{data}
\title{Expression matrix for Den Boer 2009}
\description{An data frame containing normalized values for the expression profiles from Den Boer 2009. The raw data was downloaded from Gene Expression Omnibus (GEO ID: GSE13425) and normalized using affy::rma().}
\usage{data("denboer2009.expr")}
\format{A data frame with 22283 observations (probesets) on 190 variables (samples).}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425}
\references{Den Boer, M.L., van Slegtenhorst, M., De Menezes, R.X., Cheok, M.H., Buijs-Gladdines, J.G.C.A.M., Peters, S.T.C.J.M., Van Zutven, L.J.C.M., Beverloo, H.B., Van der Spek, P.J., Escherich, G., et al. (2009) A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol, 10, 125–134.}
\examples{
data(denboer2009.expr)

## Check the dimensions of the expression matrix
dim(denboer2009.expr)

## Plot an histogram with all expression values
hist(as.vector(as.matrix((denboer2009.expr))),
     breaks=100, xlab="Expression level",
     ylab="Probesets",
     main="Den Boer 2009 expression values",
     col="cyan")
}
\keyword{datasets}
