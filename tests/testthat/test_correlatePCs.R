test_that("Correlation of the PCs", {
  pcaobj <- prcomp(t(assay(rlt_multifac)))
  res <- correlatePCs(pcaobj, colData(dds_multifac))
  
  expect_equal(dim(res), c(4, 2))
  expect_equal(colnames(res), colnames(colData(dds_multifac)))
  
  plotPCcorrs(res)
  
  plotPCcorrs(res, logp = FALSE, pc = 2)
})

