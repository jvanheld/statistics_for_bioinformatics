\name{denboer2009.pheno}
\alias{denboer2009.pheno}
\docType{data}
\title{Pheno table for denboer2009.expr dataset}
\description{
Phenotype descriptions for the samples of Den Boer (2009) cohort obtained from the GEO series GSE13425.
}
\usage{data("denboer2009.pheno")}
\format{
  A data frame with 190 observations (samples) characterized by the 6 variables.
  \describe{
    \item{\code{Sample.title}}{a factor with levels \code{BCR-ABL} \code{BCR-ABL + hyperdiploidy} \code{E2A-rearranged (E-sub)} \code{E2A-rearranged (E)} \code{E2A-rearranged (EP)} \code{hyperdiploid} \code{MLL} \code{pre-B ALL} \code{T-ALL} \code{TEL-AML1} \code{TEL-AML1 + hyperdiploidy}}
    \item{\code{Sample.source.name.ch1}}{a factor with levels \code{bone marrow or peripheral blood sample from child with acute lymphoblastic leukemia}}
    \item{\code{Sample.characteristics.ch1}}{a factor with levels \code{Precursor-B  ALL, subtype: Hyperdiploid} \code{Precursor-B ALL, subtype: BCR-ABL} \code{Precursor-B ALL, subtype: BCR-ABL (+hyperdiploidy)} \code{Precursor-B ALL, subtype: E2A-rearranged (E-sub)} \code{Precursor-B ALL, subtype: E2A-rearranged (E)} \code{Precursor-B ALL, subtype: E2A-rearranged (EP)} \code{Precursor-B ALL, subtype: MLL} \code{Precursor-B ALL, subtype: other} \code{Precursor-B ALL, subtype: TEL-AML1} \code{Precursor-B ALL, subtype: TEL-AML1 (+hyperdiploidy)} \code{T-ALL}}
    \item{\code{Sample.description}}{a factor with levels \code{Sample collected at diagnosis.}}
    \item{\code{sample.labels}}{a character vector}
    \item{\code{sample.colors}}{a character vector}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425}
\references{Den Boer, M.L., van Slegtenhorst, M., De Menezes, R.X., Cheok, M.H., Buijs-Gladdines, J.G.C.A.M., Peters, S.T.C.J.M., Van Zutven, L.J.C.M., Beverloo, H.B., Van der Spek, P.J., Escherich, G., et al. (2009) A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol, 10, 125–134.}
\examples{
data(denboer2009.pheno)

## Get field names
names(denboer2009.pheno)

## Cheack the head of the pheno table
head(denboer2009.pheno)

## Count the number of samples per sub-type of ALL
sort(table(denboer2009.pheno$Sample.characteristics.ch1),decreasing=TRUE)

## A more compact representation with short sample lables
sort(table(denboer2009.pheno$sample.labels),decreasing=TRUE)

}
\keyword{datasets}
