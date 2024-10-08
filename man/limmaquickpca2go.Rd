% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pca2go.R
\name{limmaquickpca2go}
\alias{limmaquickpca2go}
\title{Functional interpretation of the principal components, based on simple
overrepresentation analysis}
\usage{
limmaquickpca2go(
  se,
  pca_ngenes = 10000,
  inputType = "ENSEMBL",
  organism = "Mm",
  loadings_ngenes = 500,
  background_genes = NULL,
  scale = FALSE,
  ...
)
}
\arguments{
\item{se}{A \code{\link[=DESeqTransform]{DESeqTransform()}} object, with data in \code{assay(se)},
produced for example by either \code{\link[=rlog]{rlog()}} or
\code{\link[=varianceStabilizingTransformation]{varianceStabilizingTransformation()}}}

\item{pca_ngenes}{Number of genes to use for the PCA}

\item{inputType}{Input format type of the gene identifiers. Deafults to \code{ENSEMBL}, that then will
be converted to ENTREZ ids. Can assume values such as \code{ENTREZID},\code{GENENAME} or \code{SYMBOL},
like it is normally used with the \code{select} function of \code{AnnotationDbi}}

\item{organism}{Character abbreviation for the species, using \code{org.XX.eg.db} for annotation}

\item{loadings_ngenes}{Number of genes to extract the loadings (in each direction)}

\item{background_genes}{Which genes to consider as background.}

\item{scale}{Logical, defaults to FALSE, scale values for the PCA}

\item{...}{Further parameters to be passed to the goana routine}
}
\value{
A nested list object containing for each principal component the terms enriched
in each direction. This object is to be thought in combination with the displaying feature
of the main \code{\link[=pcaExplorer]{pcaExplorer()}} function
}
\description{
Extracts the genes with the highest loadings for each principal component, and
performs functional enrichment analysis on them using the simple and quick routine
provided by the \code{limma} package
}
\examples{
library("airway")
library("DESeq2")
library("limma")
data("airway", package = "airway")
airway
dds_airway <- DESeqDataSet(airway, design = ~ cell + dex)
\dontrun{
rld_airway <- rlogTransformation(dds_airway)
goquick_airway <- limmaquickpca2go(rld_airway,
                                   pca_ngenes = 10000,
                                   inputType = "ENSEMBL",
                                   organism = "Hs")
}

}
