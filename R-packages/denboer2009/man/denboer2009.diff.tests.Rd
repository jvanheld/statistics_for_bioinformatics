\name{denboer2009.diff.tests}
\alias{denboer2009.diff.tests}
\docType{data}
\title{
Differential analysis result table for denboer2009 dataset}
\description{
Results of a variety of statistical tests to detect differentially expressed genes in the microarray expressio series GSE13425 from Den Boer, 2009.

The following tests were applied:
  \describe{
    \item{Shapiro}{Normality test}
    \item{Bartlett}{Homoscedasticity test (equality of variance between groups)}
    \item{Student}{Student t-test for mean equality between two groups. This test relies on the assumptions of normality and homoscedasticity.}
    \item{Welch}{Welch t-test for mean equality between two groups. This test relies on the assumptions of normality but not homoscedasticity.}
    \item{Wilcoxon}{Wilcoxon non-parametric test for mean equality between two groups. This test does not assume normality.}
    \item{ANOVA}{One-factor ANOVA to detect differentially expressed genes between multiple groups. Assumes normality.}
    \item{Kruskal}{Kruskall-Wallis non-parametric test to detect differentially expressed genes between multiple groups. Does not assume normality.}

For each test, the result table provides the nominal p-value (pval), the e-value (eval) and the false discovery rate (fdr) estimated according to Storey and Tibshirani (2003).
  }
}
\usage{data("denboer2009.diff.tests")}
\format{
  A data frame with 22283 rows (probesets from GSE13425) and the following columns.
  \describe{
    \item{\code{A}}{a numeric vector}
    \item{\code{M}}{a numeric vector}
    \item{\code{P}}{a numeric vector}
    \item{\code{mean}}{a numeric vector}
    \item{\code{mean.goi}}{a numeric vector}
    \item{\code{mean.other}}{a numeric vector}
    \item{\code{sd}}{a numeric vector}
    \item{\code{sd.goi}}{a numeric vector}
    \item{\code{sd.other}}{a numeric vector}
    \item{\code{var}}{a numeric vector}
    \item{\code{var.goi}}{a numeric vector}
    \item{\code{var.other}}{a numeric vector}
    \item{\code{shapiro.pval}}{a numeric vector}
    \item{\code{shapiro.fdr}}{a numeric vector}
    \item{\code{shapiro.eval}}{a numeric vector}
    \item{\code{shapiro.pval.subtype.Bh}}{a numeric vector}
    \item{\code{shapiro.pval.subtype.Bo}}{a numeric vector}
    \item{\code{shapiro.pval.subtype.Bt}}{a numeric vector}
    \item{\code{shapiro.pval.subtype.T}}{a numeric vector}
    \item{\code{bartlett.pval}}{a numeric vector}
    \item{\code{bartlett.fdr}}{a numeric vector}
    \item{\code{bartlett.eval}}{a numeric vector}
    \item{\code{student.pval}}{a numeric vector}
    \item{\code{student.fdr}}{a numeric vector}
    \item{\code{student.eval}}{a numeric vector}
    \item{\code{welch.pval}}{a numeric vector}
    \item{\code{welch.fdr}}{a numeric vector}
    \item{\code{welch.eval}}{a numeric vector}
    \item{\code{wilcoxon.pval}}{a numeric vector}
    \item{\code{wilcoxon.fdr}}{a numeric vector}
    \item{\code{wilcoxon.eval}}{a numeric vector}
    \item{\code{anova.pval}}{a numeric vector}
    \item{\code{anova.fdr}}{a numeric vector}
    \item{\code{anova.eval}}{a numeric vector}
  }
}
\details{
%%  ~~ If necessary, more details than the __description__ above ~~
}
\source{\url{http://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13425}}
\references{Den Boer, M.L., van Slegtenhorst, M., De Menezes, R.X., Cheok, M.H., Buijs-Gladdines, J.G.C.A.M., Peters, S.T.C.J.M., Van Zutven, L.J.C.M., Beverloo, H.B., Van der Spek, P.J., Escherich, G., et al. (2009) A subtype of childhood acute lymphoblastic leukaemia with poor treatment outcome: a genome-wide classification study. Lancet Oncol, 10, 125–134.}
\examples{
library(denboer2009)

## List the column names of the differential expression result table
names(denboer2009.diff.tests)



## Filter out the probesets which were called "absent", i.e. they were
## barely undetected in almost all probes. Setting the threshold to
## max 170 "absent" calls filters out half of the probesets !
max.absent.samples <- 170
retained.probesets <- (denboer2009.diff.tests$A <= max.absent.samples)
sum(retained.probesets)
sum(retained.probesets) / nrow(denboer2009.expr)


## Select significant genes with a given threshold (alpha) on the FDR.
## We do this without filtering on A/M/P calls, and compare the results a posteriori.
alpha <- 0.05
fdr.columns <- grep(pattern=".fdr", names(denboer2009.diff.tests))
significant.fdr <- (denboer2009.diff.tests[,fdr.columns] < alpha) & (retained.probesets)
print(apply(significant.fdr, 2, sum)) ## Number of significant probesets per test


## Select significant genes with alpha on the e-value (much more stringent thatn FDR)
eval.columns <- grep(pattern=".eval", names(denboer2009.diff.tests))
significant.eval <- (denboer2009.diff.tests[,eval.columns] < alpha) & (retained.probesets)
data.frame(signif.fdr = apply(significant.fdr, 2, sum),
           signif.eval = apply(significant.eval, 2, sum))


}
\keyword{datasets}

