% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tTestPerRow.bootstrap.R
\name{tTestPerRow.bootstrap}
\alias{tTestPerRow.bootstrap}
\title{Estimate robustness of tTestPerRow by running a bootstrap procedure.}
\usage{
tTestPerRow.bootstrap(x, cl, iterations = 100, subset.sizes = NULL,
  replace = TRUE, discard.dup = FALSE, alpha = 0.05,
  support.quantile = 0.75, ...)
}
\arguments{
\item{x}{data frame containing one column per object and one row per feature}

\item{cl}{vector describing class membership}

\item{iterations}{Number of iterations of the bootstrap procedure}

\item{...}{Additional parameters are passed to tTestPerRow().}

\item{subset.sizes=NULL}{Named vector indicating the number os columns to 
select for each class name. If NULL (default), sizes are set equal to the 
class frequencies in the class membership vector (which only makes sense 
for the standard bootstrap procedure with replacement).}

\item{replace=TRUE}{Method for sampling the columns per class. 
The default is with replacement (bootstrap procedure). Setting replace=FALSE only 
makes sense for a sub-sampling procedure, with a specified subset.sizes vector 
indicating smaller values than the original class sizes.}

\item{discard.dup=FALSE}{Discard duplicated entries from the bootstrapped samples, 
to achieve a non-redundant bootstrap. 
In principle bootstrap is with replacement, which means that the resampled data 
has the same size as the original sample, but since it is drawn with replacement 
each element can be drawn 0, 1, 2, 3 or more times. This however creates a strong 
problem of dependency between samples, which violates the basic assumptions underlying
the t-test. To circumvent this problem, the option discard.dup filters out all duplicates 
from the bootstrapped list. The result should give similar results as a subsampling 
without replacement, of a size ~66% of the original sample size. A difference is that the 
number of elements will vary between iterations of the bootstrap, since it will depend 
on the particular number of duplicates drawn at random.}

\item{alpha=0.05}{Significance threshold, which will be applied to count the 
number of rows passing the test with aplha on p-value, e-value and FDR, 
respectively.}

\item{support.quantile=0.75}{Minimal percent of support required to declare a feature positive.
The default is to select features supported in 75\% of bootstrap iterations.}
}
\description{
Estimate robustness of tTestPerRow by running a bootstrap procedure.

The standard bootstrap standard consists in anlayzing random selection of samples
of the same size as the original dataset, but with replacement. This sampling
is performed separately on the columns of the input table corresponding to the two
 subsets defined by the sample labels, and the sampled data table is analyzed 
 with tTestPerRow(). Note that this procedure ensures resampled groups of the same 
 size as the original groups, but induces redundancy within each group, and thus 
 violates the basic assumption of independence between samples that underlies the 
 t-test.

Alternatively, this function can also be used to perform a sub-sampling (selecting 
smaller sets of columns per group) with or without replacement. Sub-sampling without 
replacement presents the advantage of preserving the independence between elements 
of each group (as far as the elements of the original groups were independent), but 
reduces sample sizes, therefore resulting in a loss of power.

A trateoff can be achieved by the jacknife procedure, which consists in sampling, 
without replacement, subsets of sizes  n1-1 and n2-2, where ni is the sample size for
the ith group. For each group, each element is thus discarded in one of the 
resampling iterations. Note that the jacknife procedure is poorly efficient to 
temperate the effect of outliers, since a given outlier will be discarded in only
one of the ni jacknife iterations, but kept in the ni-1 other iterations. 
The current version does not implement the jacknife subsampling yet, but for 
sufficiently large sample sizes, an approximation can be achieved by sub-sampling 
with subset.sizes = c(n1 -1, n2 -1).
}
\details{
First version: 2015-03
Last modification: 2015-05
}
\examples{
## Generate a random set with two samples from distinct 
## populations A and B, characterized by and m rows (features),
## among which m1 are under H1 (mA != mB) and m0 under 
## H0 (mA = mB).
m1 <- 200 ## Number of features under H_1
m0 <- 200 ## Number of features under H_0
m <- m0+m1
bootstrap.iterations <- 100

effect.size <- 1 ## Difference between means for the features under H1
sample.sizes <- c("A"=30,"B"=30)
sample.labels <- rep(names(sample.sizes), times=sample.sizes)
table(sample.labels)
row.means.g1 <- rep(0, m) ## All rows have a null mean for group 1
row.means.g2 <- c(rep(0+effect.size, m1), rep(0, m0)) ## group 2 mean differs depending on the row
rand.2grp <- data.frame(cbind(
  matrix(nrow=m, ncol=sample.sizes[1], rnorm(m=row.means.g1,sd=1,n=sample.sizes[1]*m)),
  matrix(nrow=m, ncol=sample.sizes[2], rnorm(m=row.means.g2,sd=1,n=sample.sizes[2]*m))))

## Check row-wise means per group
breaks=seq(from=-1, to=1+effect.size, by=0.025)
par(mfrow=c(2,1))
hist(apply(rand.2grp[,sample.labels=="A"],1, mean), breaks=breaks, main="Sample means, features under H0", xlab="mean per row", ylab="Rows", col="grey")
hist(apply(rand.2grp[,sample.labels=="B"],1, mean), breaks=breaks, main="Sample means, features under H1", xlab="mean per row", ylab="Rows", col="orange")
par(mfrow=c(1,1))

################################################################
## Apply Student t-test with classical bootstrap
## (draw samples of same size as original groups, with replacement).
## Set the support quantile to 0.95, in order to select only the features 
## passing the alpha threshold in at least 95\% of the iterations.
student.bootstrap <- tTestPerRow.bootstrap(x = rand.2grp, cl=sample.labels, 
   iterations=bootstrap.iterations, var.equal=TRUE, support.quantile=0.75, test.group="B")
   
## Plot comparisons between p-values obtained for the two first bootstrap iterations
# x11(width=10, height=10)
par(mfrow=c(2,2))
plotPvalCompa(student.bootstrap$p.value[,1:2], score.name="p.value", alpha=0.05, main="Control on p-value", legend.corner="topleft")
plotPvalCompa(student.bootstrap$fdr[,1:2], score.name="fdr", alpha=0.05, main="Control on FDR", legend.corner="topleft")
plotPvalCompa(student.bootstrap$e.value[,1:2], score.name="e.value", alpha=1, main="Permissive control on e-value (<= 1)", legend.corner="topleft")
plotPvalCompa(student.bootstrap$e.value[,1:2], score.name="e.value", alpha=0.05, main="Stringent control on e-value", legend.corner="topleft")
par(mfrow=c(1,1))


################################################################
## Plot two histograms showing the distributions of support values for features under H1 and H0, respectively
# x11(width=5, height=8)
par(mfrow=c(2,2))
hist(student.bootstrap$stats.per.row$fdr.support[row.means.g2 == row.means.g1], 
     main="Bootstrap support for features under H0",
     xlab="Support",
     ylab="Number of features", col="grey",
     breaks=0:bootstrap.iterations)
abline(v=student.bootstrap$support.threshold, col="red", lwd=2)
hist(student.bootstrap$stats.per.row$fdr.support[row.means.g2 != row.means.g1], 
     main="Bootstrap support for features under H1",
     xlab="Support",
     ylab="Number of features", col="orange",
     breaks=0:bootstrap.iterations)
abline(v=student.bootstrap$support.threshold, col="red", lwd=2)
tTestPerRow.bootstrap.hist(student.bootstrap, plot.dcdf=TRUE, lwd=2,
     col="#BBCCFF", legend.corner="topright")
par(mfrow=c(1,1))

################################################################
## Subsampling: apply Student t-test on small-size sample subsets, 
## drew witout replacement.
student.subsampled.n10 <- tTestPerRow.bootstrap(x = rand.2grp, cl=sample.labels, test.group="B",
    subset.sizes=c("A"=10,"B"=10), replace=FALSE, iterations=100, var.equal=TRUE, 
    support.quantile=0.75)

student.subsampled.n20 <- tTestPerRow.bootstrap(x = rand.2grp, cl=sample.labels, test.group="B",
    subset.sizes=c("A"=20,"B"=20), replace=FALSE, iterations=100, var.equal=TRUE, 
    support.quantile=0.75)

################################################################
## "Greedy" sub-sampling: sub-sampling without replacement and 
## maximal subset sizes (n1-1, n2-1).
student.subsampled.greedy <- tTestPerRow.bootstrap(x = rand.2grp, cl=sample.labels, test.group="B",
    subset.sizes=sample.sizes-1, replace=FALSE, iterations=100, var.equal=TRUE, 
    support.quantile=0.75)
               
                                             
################################################################
## Draw Volcano plots for the full dataset, bootstrapped 
## and sub-sampled data.
# x11(width=10, height=10)
xlim <- c(
    round(min(unlist(student.bootstrap$stats.per.row$effect.size.min)), digits=1), 
    round(max(unlist(student.bootstrap$stats.per.row$effect.size.max)), digits=2))
ylim <- c(0, 1.1*ceil(-log10(min(unlist(student.bootstrap$fdr)))))
par(mfrow=c(3,2))
## Classical volcano plot
tTestPerRow.plotVolcano(student.bootstrap$full.set.test, legend.corner="topleft", ylim=ylim, xlim=xlim,
    main=paste(sep="", "Volcano plot: ", "n1=", sample.sizes[1], ", n2=", sample.sizes[2]))
## Volcano plot with confidence intervals
tTestPerRow.plotVolcano(student.bootstrap$full.set.test, legend.corner="topleft", ylim=ylim, xlim=xlim, plot.ci=TRUE,
    main=paste(sep="", "Confidence volcano: ", "n1=", sample.sizes[1], ", n2=", sample.sizes[2]))
## Bootstrap volcano
tTestPerRow.bootstrap.VolcanoBoxPlot(student.bootstrap, legend.corner="topleft", 
    plot.sig.boxes=TRUE, plot.effect.boxes=FALSE, plot.rectangles=FALSE, ylim=ylim, xlim=xlim,
    main=paste(sep="", "Bootstrap volcano: ", "n1=", sample.sizes[1], ", n2=", sample.sizes[2]))
## Subsampling volcano with subset.sizes=c(20,20)
tTestPerRow.bootstrap.VolcanoBoxPlot(student.subsampled.n20, legend.corner="topleft", 
    plot.sig.boxes=TRUE, plot.effect.boxes=FALSE, plot.rectangles=FALSE, ylim=ylim, xlim=xlim,
    main=paste(sep="", "Subsampling volcano: ", "n1=", 20, ", n2=", 20))
## Subsampling volcano with subset.sizes=c(10,10)
tTestPerRow.bootstrap.VolcanoBoxPlot(student.subsampled.n10, legend.corner="topleft", 
    plot.sig.boxes=TRUE, plot.effect.boxes=FALSE, plot.rectangles=FALSE, ylim=ylim, xlim=xlim,
    main=paste(sep="", "Subsampling volcano: ", "n1=", 10, ", n2=", 10))
## Greedy subsampling  with subset.sizes=c(n1-1,n2-1)
tTestPerRow.bootstrap.VolcanoBoxPlot(student.subsampled.greedy, legend.corner="topleft", 
    plot.sig.boxes=TRUE, plot.effect.boxes=FALSE, plot.rectangles=FALSE, ylim=ylim, xlim=xlim,
    main=paste(sep="", "Greedy subsampling: ", "n1=", sample.sizes[2]-1, ", n2=", sample.sizes[2]-1))
par(mfrow=c(1,1))


}
\author{
Jacques van Helden (\email{Jacques.van-Helden@univ-amu.fr})
}

