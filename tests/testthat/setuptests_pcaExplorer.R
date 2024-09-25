suppressPackageStartupMessages({
  library("DESeq2")
  library("SummarizedExperiment")
  library("airway")
  library("AnnotationDbi")
  library("org.Hs.eg.db")
})

# prepping the test datasets only once -----------------------------------------
dds <- makeExampleDESeqDataSet(n = 1000, m = 8)
rlt <- rlogTransformation(dds)
cm <- counts(dds)
cd <- colData(dds)


dds_multifac <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3, betaSD_tissue = 1)
rlt_multifac <- rlogTransformation(dds_multifac)


data("airway", package = "airway")
dds_airway <- DESeqDataSet(airway, design = ~ cell + dex)
dds_airway <- DESeq(dds_airway)
res_airway <- results(dds_airway)

rld_airway <- rlogTransformation(dds_airway)

res_airway$symbol <- mapIds(org.Hs.eg.db,
                            keys = row.names(res_airway),
                            column = "SYMBOL",
                            keytype = "ENSEMBL",
                            multiVals = "first")
res_airway$entrez <- mapIds(org.Hs.eg.db,
                            keys = row.names(res_airway),
                            column = "ENTREZID",
                            keytype = "ENSEMBL",
                            multiVals = "first")
