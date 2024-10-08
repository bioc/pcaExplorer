% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pcaplot.R
\name{pcaplot3d}
\alias{pcaplot3d}
\title{Sample PCA plot for transformed data}
\usage{
pcaplot3d(
  x,
  intgroup = "condition",
  ntop = 500,
  returnData = FALSE,
  title = NULL,
  pcX = 1,
  pcY = 2,
  pcZ = 3,
  text_labels = TRUE,
  point_size = 3
)
}
\arguments{
\item{x}{A \code{\link[=DESeqTransform]{DESeqTransform()}} object, with data in \code{assay(x)},
produced for example by either \code{\link[=rlog]{rlog()}} or
\code{\link[=varianceStabilizingTransformation]{varianceStabilizingTransformation()}}}

\item{intgroup}{Interesting groups: a character vector of
names in \code{colData(x)} to use for grouping}

\item{ntop}{Number of top genes to use for principal components,
selected by highest row variance}

\item{returnData}{logical, if TRUE returns a data.frame for further use, containing the
selected principal components and intgroup covariates for custom plotting}

\item{title}{The plot title}

\item{pcX}{The principal component to display on the x axis}

\item{pcY}{The principal component to display on the y axis}

\item{pcZ}{The principal component to display on the z axis}

\item{text_labels}{Logical, whether to display the labels with the sample identifiers}

\item{point_size}{Integer, the size of the points for the samples}
}
\value{
A html-based visualization of the 3d PCA plot
}
\description{
Plots the results of PCA on a 3-dimensional space, interactively
}
\examples{
dds <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3, betaSD_tissue = 1)
rlt <- DESeq2::rlogTransformation(dds)
pcaplot3d(rlt, ntop = 200)
}
