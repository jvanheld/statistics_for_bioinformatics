\name{denboer2009-package}
\alias{denboer2009-package}
\alias{denboer2009}
\docType{package}
\title{Den Boer (2009) pre-normalized expression profiles}
\description{Pre-normalized (affy::rma) expression values for the transcriptome microarray profiles from Den Boer et al. (2009)}
\details{
\tabular{ll}{
Package: \tab denboer2009\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2015-03-04\cr
License: \tab What license is it under?\cr
}
The package contains the following objects:
\tabular{ll}{
denboer2009.expr: \tab A data frame with 22283 observations (probesets) on 190 variables (samples).\cr
denboer2009.pheno: \tab A data frame with phenotypic data for each sample.\cr
denboer2009.group.colors: \tab Conventional color assigned to each group (cancer subtype) for the drawings.\cr
denboer2009.group.labels: \tab Abbreviated label assigned to each group (cancer subtype) for the drawings.\cr
}


}
\author{
Jacques van Helden <Jacques.van-Helden@univ-amu.fr>

Maintainer: Jacques van Helden <Jacques.van-Helden@univ-amu.fr>
}
\source{http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425}
\references{
Den Boer, M.L., van Slegtenhorst, M., De Menezes, R.X., Cheok, M.H., Buijs-Gladdines, J.G.C.A.M., Peters, S.T.C.J.M., Van Zutven, L.J.C.M., Beverloo, H.B., Van der Spek, P.J., Escherich, G., et al. (2009) A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol, 10, 125–134.
}
\keyword{ package ALL}
\seealso{
  \code{\link{stats4bioinfo}}
}
\examples{

## Load the library
library(denboer2009)

## Load the data set from Den Boer 2009
data(denboer2009.expr)

## Check the dimensions of the expression table
dim(denboer2009.expr)

## Check the fields in the phenotype data
data(denboer2009.pheno)

## Count the number of samples per cancer subtype
print(sort(table(denboer2009.pheno$Sample.characteristics.ch1),decreasing=TRUE))

}
