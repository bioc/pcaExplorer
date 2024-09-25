test_that("Checks on the functional enrichment of subset of genes/genes with hi loadings",{
  resOrdered <- as.data.frame(res_airway[order(res_airway$padj), ])
  de_df <- resOrdered[resOrdered$padj < .05 & !is.na(resOrdered$padj), ]
  de_symbols <- de_df$symbol
  bg_ids <- rownames(dds_airway)[rowSums(counts(dds_airway)) > 0]
  bg_symbols <- mapIds(org.Hs.eg.db,
                       keys = bg_ids,
                       column = "SYMBOL",
                       keytype = "ENSEMBL",
                       multiVals = "first")
  library(topGO)
  
  expect_is(de_symbols, "character")
  expect_is(bg_symbols, "character")
  
  # topgoDE_airway <- topGOtable(de_symbols, bg_symbols,
  #                              ontology = "BP",
  #                              mapping = "org.Hs.eg.db",
  #                              geneID = "symbol")
  #
  # expect_is(topgoDE_airway,"data.frame")
  ngenes_pca <- 500
  
  goquick_airway <- limmaquickpca2go(rld_airway,
                                     pca_ngenes = ngenes_pca,
                                     inputType = "ENSEMBL",
                                     organism = "Hs")
  
  expect_type(goquick_airway, "list")
  expect_equal(length(goquick_airway), 4)
  sapply(goquick_airway, names)
  expect_equal(attr(goquick_airway, "n_genesforpca"), ngenes_pca)
  
  expect_error(
    expect_warning(
      limmaquickpca2go(rld_airway,
                                pca_ngenes = ngenes_pca,
                                inputType = "ENSEMBL",
                                organism = "foo")
    )
  ) # additionally throws a warning
})
