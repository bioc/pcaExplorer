test_that("Checks on the pca on the genes", {
  groups <- colData(dds_multifac)$condition
  cols <- scales::hue_pal()(2)[groups]
  p <- genespca(rlt_multifac, ntop = 100, arrowColors = cols, groupNames = groups)
  
  expect_true(is(p, "gg"))
  
  dat <- genespca(rlt_multifac, ntop = 100, arrowColors = cols, groupNames = groups, returnData = TRUE)
  
  p2 <- genespca(rlt_multifac, ntop = 100)
  p3 <- genespca(rlt_multifac, ntop = 100, arrowColors = "green")
  
  expect_error(genespca(rlt_multifac, ntop = 100, arrowColors = c("green", "red")))
  
  groups_multi <- interaction(as.data.frame(colData(rlt_multifac)[, c("condition", "tissue")]))
  cols_multi <- scales::hue_pal()(length(levels(groups_multi)))[factor(groups_multi)]
  p4 <- genespca(rlt_multifac, ntop = 100, arrowColors = cols_multi, groupNames = groups_multi)
  
  expect_true(is(p4, "gg"))
})

