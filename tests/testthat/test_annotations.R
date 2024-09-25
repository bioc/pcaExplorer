test_that("Annotation data frame retrieval", {
  anno_df <- get_annotation_orgdb(dds_airway, "org.Hs.eg.db", "ENSEMBL")
  
  expect_s3_class(anno_df, "data.frame")
  expect_true(all(dim(anno_df) == c(63677, 2)))
})