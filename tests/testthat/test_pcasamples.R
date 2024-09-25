test_that("Checks on the pca on the samples", {
  pcaobj <- prcomp(t(assay(rlt_multifac)))
  
  colData(dds_multifac)
  
  pcaplot(rlt_multifac)
  dat <- pcaplot(rlt_multifac, returnData = TRUE)
  
  p <- pcaplot(rlt_multifac, intgroup = c("condition", "tissue"))
  expect_true(is(p, "gg"))
  
  dat <- pcaplot(rlt_multifac, intgroup = c("condition", "tissue"), returnData = TRUE)
  
  expect_error(pcaplot(rlt_multifac, intgroup = "foo"))
  
  p2 <- pcascree(pcaobj)
  expect_true(is(p2, "gg"))
  p3 <- pcascree(pcaobj, type = "cev")
  expect_true(is(p3, "gg"))
  expect_error(pcascree(pcaobj, type = "foo"))
})
