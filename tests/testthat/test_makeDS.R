test_that("Check that example dds is generated correctly", {
  dds <- makeExampleDESeqDataSet_multifac(betaSD_condition = 3, betaSD_tissue = 1)
  
  expect_equal(names(colData(dds)), c("condition", "tissue"))
})
