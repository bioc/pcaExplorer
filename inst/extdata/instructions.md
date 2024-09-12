*This information is also contained in the `pcaExplorer` package vignette. For more
information on the functions of the `pcaExplorer` package, please refer to the
vignette and/or the documentation.*

## Getting started

`pcaExplorer` is an R package distributed as part of the [Bioconductor](http://bioconductor.org)
project. To install the package, start R and enter:

```r
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("pcaExplorer")
```

If you prefer, you can install and use the development version, which can be 
retrieved via Github (https://github.com/federicomarini/pcaExplorer). To do so, use

```r
library("devtools")
install_github("federicomarini/pcaExplorer")
```

Once `pcaExplorer` is installed, it can be loaded by the following command.

```r
library("pcaExplorer")
```

## Introduction

`pcaExplorer` is a Bioconductor package containing a Shiny application for
analyzing expression data in different conditions and experimental factors. 

It is a general-purpose interactive companion tool for RNA-seq analysis, which 
guides the user in exploring the Principal Components of the data under inspection.

`pcaExplorer` provides tools and functionality to detect outlier samples, genes
that show particular patterns, and additionally provides a functional interpretation of 
the principal components for further quality assessment and hypothesis generation
on the input data. 

Moreover, a novel visualization approach is presented to simultaneously assess 
the effect of more than one experimental factor on the expression levels.

Thanks to its interactive/reactive design, it is designed to become a practical
companion to any RNA-seq dataset analysis, making exploratory data analysis 
accessible also to the bench biologist, while providing additional insight also
for the experienced data analyst.

Starting from development version 1.1.3, `pcaExplorer` supports reproducible 
research with state saving and automated report generation. 

## Citation info

If you use `pcaExplorer` for your analysis, please cite it as here below:

```r
citation("pcaExplorer")
```

```
## 
## To cite package 'pcaExplorer' in publications use:
## 
##   Federico Marini (2016). pcaExplorer: Interactive Visualization
##   of RNA-seq Data Using a Principal Components Approach. R package
##   version 1.1.3. https://github.com/federicomarini/pcaExplorer
## 
## A BibTeX entry for LaTeX users is
## 
##   @Manual{,
##     title = {pcaExplorer: Interactive Visualization of RNA-seq Data Using a Principal Components Approach},
##     author = {Federico Marini},
##     year = {2016},
##     note = {R package version 1.1.3},
##     url = {https://github.com/federicomarini/pcaExplorer},
##   }
```

## Launching the application

After loading the package, the `pcaExplorer` app can be launched in different modes:

- `pcaExplorer(dds = dds, rlt = rlt)`, where `dds` is a `DESeqDataSet` object and `rlt` is a `DESeqTransform`
object, which were created during an existing session for the analysis of an RNA-seq
dataset with the `DESeq2` package

- `pcaExplorer(dds = dds)`, where `dds` is a `DESeqDataSet` object. The `rlt` object is automatically 
computed upon launch.

- `pcaExplorer(countmatrix = countmatrix, coldata = coldata)`, where `countmatrix` is a count matrix, generated
after assigning reads to features such as genes via tools such as `HTSeq-count` or `featureCounts`, and `coldata`
is a data frame containing the experimental covariates of the experiments, such as condition, tissue, cell line,
run batch and so on.

- `pcaExplorer()`, and then subsequently uploading the count matrix and the covariates data frame through the 
user interface. These files need to be formatted as tab separated files, which is a common format for storing
such count values.

Additional parameters and objects that can be provided to the main `pcaExplorer` function are:

- `pca2go`, which is an object created by the `pca2go` function, which scans the genes with high loadings in 
each principal component and each direction, and looks for functions (such as GO Biological Processes) that 
are enriched above the background. The offline `pca2go` function is based on the routines and algorithms of 
the `topGO` package, but as an alternative, this object can be computed live during the execution of the app
exploiting the `goana` function, provided by the `limma` package. Although this likely provides more general
(and probably less informative) functions, it is a good compromise for obtaining a further data interpretation.

- `annotation`, a data frame object, with `row.names` as gene identifiers (e.g. ENSEMBL ids) identical to the 
row names of the count matrix or `dds` object, and an extra column `gene_name`, containing e.g. HGNC-based 
gene symbols. This can be used for making information extraction easier, as ENSEMBL ids (a usual choice when
assigning reads to features) do not provide an immediate readout for which gene they refer to. This can be
either passed as a parameter when launching the app, or also uploaded as a tab separated text file. The package
provides two functions, `get_annotation` and `get_annotation_orgdb`, as a convenient wrapper to obtain the updated
annotation information, respectively from `biomaRt` or via the `org.XX.eg.db` packages.

## The controls sidebar

Most of the input controls are located in the sidebar, some are as well in the individual tabs of the app.
By changing one or more of the input parameters, the user can get a fine control on what is displayed.

### App settings

Here are the parameters that set input values for most of the tabs. By hovering over with the mouse,
the user can receive additional information on how to set the parameter, powered by the `shinyBS` package.

- **x-axis PC** - Select the principal component to display on the x axis
- **y-axis PC** - Select the principal component to display on the y axis
- **Group/color by** - Select the group of samples to stratify the analysis. Can also assume multiple values.
- **Nr of (most variable) genes** - Number of genes to select for computing the principal components. The top n genes are
selected ranked by their variance inter-samples
- **Alpha** - Color transparency for the plots. Can assume values from 0 (transparent) to 1 (opaque)
- **Labels size** - Size of the labels for the samples in the principal components plots
- **Points size** - Size of the points to be plotted in the principal components plots
- **Variable name size** - Size of the labels for the genes PCA - correspond to the samples names
- **Scaling factor** - Scale value for resizing the arrow corresponding to the variables in the PCA for the genes. It
should be used for mere visualization purposes
- **Color palette** - Select the color palette to be used in the principal components plots. The number of colors 
is selected automatically according to the number of samples and to the levels of the factors of interest
and their interactions
- **Plot style for gene counts** - Plot either boxplots or violin plots, with jittered points superimposed 

### Plot export settings        

Width and height for the figures to export are input here in cm.

Additional controls available in the single tabs are also assisted by tooltips that show on hovering the mouse.
Normally they are tightly related to the plot/output they are placed nearby.

## The task menu

The task menu, accessible by clicking on the cog icon in the upper right part of the application, provides two 
functionalities:

- `Exit pcaExplorer & save` will close the application and store the content of the `input` and `values` reactive 
objects in two list objects made available in the global environment, called `pcaExplorer_inputs_YYYYMMDD_HHMMSS` and 
`pcaExplorer_values_YYYYMMDD_HHMMSS`
- `Save State as .RData` will similarly store `LiveInputs` and `r_data` in a binary file named
`pcaExplorerState_YYYYMMDD_HHMMSS.Rdata`, without closing the application 

## The app panels

The `pcaExplorer` app is structured in different panels, each focused on a different aspect of the 
data exploration. 

Most of the panels work extensively with click-based and brush-based interactions, to gain additional
depth in the explorations, for example by zooming, subsetting, selecting. This is possible thanks to the 
recent developments in the `shiny` package/framework.

The available panels are the described in the following subsections.

### Data Upload

These **file input** controls are available when no `dds` or `countmatrix` + `coldata` are provided. Additionally,
it is possible to upload the `annotation` data frame.

When the objects are already passed as parameters, a brief overview/summary for them is displayed.

### Instructions

This is where you most likely are reading this text (otherwise in the package vignette). 

### Counts Table

Interactive tables for the raw, normalized or (r)log-transformed counts are shown in this tab.
The user can also generate a sample-to-sample correlation scatter plot with the selected data.

### Data Overview

This panel displays information on the objects in use, either passed as parameters or 
generated from the count matrix provided. Displayed information comprise the design metadata,
a sample to sample distance heatmap, the number of million of reads per sample and some
basic summary for the counts.

### Samples View

This panel displays the PCA projections of sample expression profiles onto any pair of components,
a scree plot, a zoomed PCA plot, a plot of the genes with top and bottom loadings. Additionally, this section 
presents a PCA plot where it is possible to remove samples deemed to be outliers in the analysis, which is 
very useful to check the effect of excluding them. If needed, an interactive 3D visualization of the principal 
components is also available.

### Genes View

This panel displays the PCA projections of genes abundances onto any pair of components, with samples
as biplot variables, to identify interesting groups of genes. Zooming is also possible, and clicking on single
genes, a boxplot is returned, grouped by the factors of interest. A static and an interactive heatmap are 
provided, including the subset of selected genes, also displayed as (standardized) expression profiles across the 
samples. These are also reported in `datatable` objects, accessible in the bottom part of the tab.

### GeneFinder

The user can search and display the expression values of a gene of interest, either by ID or gene
name, as provided in the `annotation`. A handy panel for quick screening of shortlisted genes, again grouped by
the factors of interest. The graphic can be readily exported as it is, and this can be iterated on a shortlisted
set of genes. For each of them, the underlying data is displayed in an interactive table, also exportable with a 
click.

### PCA2GO

This panel shows the functional annotation of the principal components, with GO functions enriched in the 
genes with high loadings on the selected principal components. It allows for the live computing of the object,
that can otherwise provided as a parameter when launching the app. The panel displays a PCA plot for the 
samples, surrounded on each side by the tables with the functions enriched in each component and direction.

### Multifactor Exploration

This panel allows for the multifactor exploration of datasets with 2 or more experimental factors. The user has to select 
first the two factors and the levels for each. Then, it is possible to combine samples from Factor1-Level1 in the selected
order by clicking on each sample name, one for each level available in the selected Factor2. In order to build the matrix, 
an equal number of samples for each level of Factor 1 is required, to keep the design somehow balanced.
A typical case for choosing factors 1 and 2 is for example when different conditions and tissues are present.

Once constructed, a plot is returned that tries to represent simultaneously the effect of the two factors on the data.
Each gene is represented by a dot-line-dot structure, with the color that is indicating the tissue (factor 2) where the gene 
is mostly expressed. Each gene has two dots, one for each condition level (factor 1), and the position of the points is dictated
by the scores of the principal components calculated on the matrix object. The line connecting the dots is darker when the 
tissue where the gene is mostly expressed varies throughout the conditions. 

This representation is under active development, and it is promising for identifying interesting sets or clusters of genes
according to their behavior on the Principal Components subspaces. Zooming and exporting of the underlying genes is also
allowed by brushing on the main plot.

### Report Editor

The report editor is the backbone for generating and editing the interactive report on the basis of the 
uploaded data and the current state of the application. General `Markdown options` and `Editor options`
are available, and the text editor, based on the `shinyAce` package, contains a comprehensive template 
report, that can be edited to the best convenience of the user.

The editor supports R code autocompletion, making it easy to add new code chunks for additional sections.
A preview is available in the tab itself, and the report can be generated, saved and subsequently shared 
with simple mouse clicks.

### About

Contains general information on `pcaExplorer`, including the developer's contact, the link to
the development version in Github, as well as the output of `sessionInfo`, to use for reproducibility sake - 
or bug reporting. Information for citing `pcaExplorer` is also reported.

## Running `pcaExplorer` on published datasets

We can run `pcaExplorer` for demonstration purpose on published datasets that are available as SummarizedExperiment
in an experiment Bioconductor packages.

We will use the `airway` dataset, which can be installed with this command

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("airway")
```

This package provides a RangedSummarizedExperiment object of read counts in genes for an RNA-Seq experiment 
on four human airway smooth muscle cell lines treated with dexamethasone. More details such as gene models and 
count quantifications can be found in the `airway` package vignette. 

To run `pcaExplorer` on this dataset, the following commands are required

```
library(airway)

data(airway)

dds_airway <- DESeqDataSet(airway,design=~dex+cell)
dds_airway
rld_airway <- rlogTransformation(dds_airway)
rld_airway
pcaExplorer(dds = dds_airway,
            rlt = rld_airway)
```
The `annotation` for this dataset can be built by exploiting the `org.Hs.eg.db` package

```
library(org.Hs.eg.db)
genenames_airway <- mapIds(org.Hs.eg.db,keys = rownames(dds_airway),column = "SYMBOL",keytype="ENSEMBL")
annotation_airway <- data.frame(gene_name = genenames_airway,
                                row.names = rownames(dds_airway),
                                stringsAsFactors = FALSE)
head(annotation_airway)                                
```

or alternatively, by using the `get_annotation` or `get_annotation_orgdb` wrappers.

```
anno_df_orgdb <- get_annotation_orgdb(dds = dds_airway,
                                      orgdb_species = "org.Hs.eg.db",
                                      idtype = "ENSEMBL")

anno_df_biomart <- get_annotation(dds = dds_airway,
                                  biomart_dataset = "hsapiens_gene_ensembl",
                                  idtype = "ensembl_gene_id")
```

Then again, the app can be launched with 

```
pcaExplorer(dds = dds_airway,
            rlt = rld_airway,
            annotation = annotation_airway)
```

If desired, alternatives can be used. See the well written annotation workflow available at the Bioconductor site (https://bioconductor.org/help/workflows/annotation/annotation/).

## Running `pcaExplorer` on synthetic datasets

For testing and demonstration purposes, a function is also available to generate synthetic datasets whose counts
are generated based on two or more experimental factors.

This can be called with the command

```
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3,betaSD_tissue = 1)
```

See all the available parameters by typing `?makeExampleDESeqDataSet_multifac`. Credits are given to the initial
implementation by Mike Love in the `DESeq2` package.

The following steps run the app with the synthetic dataset

```
dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 1,betaSD_tissue = 3)
dds_multifac
rld_multifac <- rlogTransformation(dds_multifac)
rld_multifac
## checking how the samples cluster on the PCA plot
pcaplot(rld_multifac,intgroup = c("condition","tissue"))
```

Launch the app for exploring this dataset with 

```
pcaExplorer(dds = dds_multifac,
            rlt = rld_multifac)
```

When such a dataset is provided, the panel for multifactorial exploration is also usable at its best.

## Functions exported by the package for standalone usage

The functions exported by the `pcaExplorer` package can be also used in a standalone scenario,
provided the required objects are in the working environment. They are listed here for an overview,
but please refer to the documentation for additional details.

- `pcaplot` plots the sample PCA for `DESeqTransform` objects, such as rlog-transformed data. This is 
the workhorse of the Samples View tab
- `pcaplot3d` - same as for `pcaplot`, but it uses the `threejs` package for the 3d interactive view.
- `pcascree` produces a scree plot of the PC computed on the samples. A `prcomp` object needs to be 
passed as main argument
- `correlatePCs` and `plotPCcorrs` respectively compute and plot significance of the (cor)relation 
of each covariate versus a principal component. The input for `correlatePCs` is a `prcomp` object
- `hi_loadings` extracts and optionally plots the genes with the highest loadings
- `genespca` computes and plots the principal components of the genes, eventually displaying 
the samples as in a typical biplot visualization. This is the function in action for the Genes View tab
- `topGOtable` is a convenient wrapper for extracting functional GO terms enriched in a subset of genes 
(such as the differentially expressed genes), based on the algorithm and the implementation in the topGO package
- `pca2go` provides a functional interpretation of the principal components, by extracting the genes
with the highest loadings for each PC, and then runs internally `topGOtable` on them for efficient functional
enrichment analysis. Needs a `DESeqTransform` object as main parameter
- `limmaquickpca2go` is an alternative to `pca2go`, used in the live running app, thanks to its fast 
implementation based on the `limma::goana` function.
- `makeExampleDESeqDataSet_multifac` constructs a simulated `DESeqDataSet` of Negative Binomial dataset
from different conditions. The fold changes between the conditions can be adjusted with the `betaSD_condition`
`betaSD_tissue` arguments
- `distro_expr` plots the distribution of expression values, either with density lines, boxplots or 
violin plots
- `geneprofiler` plots the profile expression of a subset of genes, optionally as standardized values
- `get_annotation` and `get_annotation_orgdb` retrieve the latest annotations for the `dds` object, to be
used in the call to the `pcaExplorer` function. They use respectively the `biomaRt` package
and the `org.XX.eg.db` packages
- `pair_corr` plots the pairwise scatter plots and computes the correlation coefficient on the 
expression matrix provided.

For more information on the functions of the `pcaExplorer` package, please refer to the
vignette and/or the documentation.

## Further development

Additional functionality for the `pcaExplorer` will be added in the future, as it is tightly related to a topic
under current development research. 

Improvements, suggestions, bugs, issues and feedback of any type can be sent to marinif@uni-mainz.de.
