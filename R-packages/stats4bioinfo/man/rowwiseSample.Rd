% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/negativeControls.R
\name{rowwiseSample}
\alias{rowwiseSample}
\title{Permute the values of each row of the input matrix or data frame.}
\usage{
rowwiseSample(x, columns = ncol(x), replace = FALSE)
}
\arguments{
\item{x}{A matrix or data frame}

\item{ncol=ncol(x)}{Number of columns of the sampled matrix  (passed as argument size to base::sample)}

\item{replace=FALSE}{Sampling with replacement (passed to base::sample).}

\item{...}{Additional parameters are passed to base::sample(). 
This extends the possible usages of stats4bioinfo::rowwiseSample().
For example, the argument replace=TRUE will perform a bootstrap of the input
table: each value of the input matrix can appear 0, 1 or more times in 
the corresponding row of the permuted matrix.}
}
\value{
A data frame of same dimensions as the input matrix/data frame (unless the 
option size is used), with row-wise permuted values.
}
\description{
Random permutation of the values on each row of the input data frame.

After permutation, each row thus contains exactly the same values as in 
the original expression matrix, but there should be no specific order or 
distinction between groups. 

Row-wise permuted matrices provide realistic negative controls for several 
approaches in microarray or RNA-seq analysis: differential expression, 
clustering, supervised classification.
}
\details{
First version: 2015-03
Last modification: 2015-03
}
\examples{

################################################################
## Generate an artificial matrix with each row identical
x <- matrix(data=1:10, nrow=20, ncol=10, byrow=TRUE)
print(x)

################################################################
## Permute the values of each row of the matrix
print(rowwiseSample(x, replace=FALSE))

################################################################
## Sampling with replacement
print(rowwiseSample(x, replace=TRUE))

################################################################
## Sampling with a smaller number of columns
print(rowwiseSample(x, columns=4, replace=FALSE))

################################################################
## Sampling with a larger number of columns and replacement
print(rowwiseSample(x, columns=15, replace=TRUE))

################################################################
## Load example data set from Den Boer, 2009
library(denboer2009)
data(denboer2009.expr)     ## Load expression table
data(denboer2009.pheno)     ## Load phenotype table

################################################################
## Define group labels and group of interest
g <- denboer2009.pheno$sample.labels
group1 = "Bo" ## First cancer type for mean comparison
group2 = "Bt" ## Second cancer type for mean comparison
selected.samples <- (g == group1) | (g == group2)
selected.labels <- denboer2009.pheno$sample.labels[selected.samples]
print (paste("Groups", group1, "and", group2, ":", sum(selected.samples), "selected samples"))

## Run Welch test on the original values
denboer.welch <- meanEqualityTests(
    denboer2009.expr[selected.samples], 
    g=selected.labels, goi=group1,
    selected.tests="welch")
                 
################################################################
## Draw volcano plot of Welch test result on denboer2009 dataset
meanEqualityTests.plotVolcano(denboer.welch, test="welch", 
    main="Den Boer 2009, Welch volcano", 
    legend.corner="topright",)
    
################################################################
## Draw the distribution of p-values for Den Boer dataset. 
## There is a strong peak at low p-values (<5\%), which corresponds 
## to the differentially expressed genes.
mulitpleTestingCorrections.plotPvalDistrib(
     denboer.welch$welch.multicor,
     main="Den Boer 2009, Welch p-values")
     
################################################################
## Permute the values of denboer2009 and run Welch test
permuted.profiles <- rowwiseSample(x=denboer2009.expr[selected.samples])

perm.welch <- meanEqualityTests(permuted.profiles, 
   g=selected.labels, goi=group1,
   selected.tests="welch")
                 
################################################################
## Draw volcano plot of Welch test result with the permuted values
## This should show more or less no significant features.
meanEqualityTests.plotVolcano(perm.welch, 
     test="welch", main="Permuted Den Boer 2009, Welch volcano",
     legend.corner="topright")

                                           
################################################################
## Draw the distribution of p-values for the row-wise permuted matrix. 
## This should give a flat distribution. However, the estimated proportion
## of truly null (pi0) is lower than 1, because sometimes the permutation
## creates unbalanced groups -> the randomized samples have different means. 
mulitpleTestingCorrections.plotPvalDistrib(
     perm.welch$welch.multicor, 
     main="Permuted Den Boer 2009, Welch p-values")
par(mfrow=c(1,1))
 
}
\author{
Jacques van Helden (\email{Jacques.van-Helden@univ-amu.fr})
}

