% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pcaplot.R
\name{pcaplot}
\alias{pcaplot}
\title{Sample PCA plot for transformed data}
\usage{
pcaplot(
  x,
  intgroup = NULL,
  ntop = 500,
  returnData = FALSE,
  title = NULL,
  pcX = 1,
  pcY = 2,
  text_labels = TRUE,
  point_size = 3,
  ellipse = TRUE,
  ellipse.prob = 0.95
)
}
\arguments{
\item{x}{A \code{\link[=DESeqTransform]{DESeqTransform()}} object, with data in \code{assay(x)},
produced for example by either \code{\link[=rlog]{rlog()}} or
\code{\link[=varianceStabilizingTransformation]{varianceStabilizingTransformation()}}/\code{\link[=vst]{vst()}}}

\item{intgroup}{Interesting groups: a character vector of
names in \code{colData(x)} to use for grouping. Defaults to NULL, which would then
select the first column of the \code{colData} slot}

\item{ntop}{Number of top genes to use for principal components,
selected by highest row variance}

\item{returnData}{logical, if TRUE returns a data.frame for further use, containing the
selected principal components and intgroup covariates for custom plotting}

\item{title}{The plot title}

\item{pcX}{The principal component to display on the x axis}

\item{pcY}{The principal component to display on the y axis}

\item{text_labels}{Logical, whether to display the labels with the sample identifiers}

\item{point_size}{Integer, the size of the points for the samples}

\item{ellipse}{Logical, whether to display the confidence ellipse for the selected groups}

\item{ellipse.prob}{Numeric, a value in the interval [0;1)}
}
\value{
An object created by \code{ggplot}, which can be assigned and further customized.
}
\description{
Plots the results of PCA on a 2-dimensional space
}
\examples{
dds <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3, betaSD_tissue = 1)
rlt <- DESeq2::rlogTransformation(dds)
pcaplot(rlt, ntop = 200)

}
