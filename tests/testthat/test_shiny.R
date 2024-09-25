test_that("Shiny app is generated", {
  expect_is(pcaExplorer(), "shiny.appobj")
  
  expect_is(pcaExplorer(dds, rlt), "shiny.appobj")
  
  expect_is(pcaExplorer(countmatrix = cm, coldata = cd), "shiny.appobj")
  
  expect_is(pcaExplorer(dds = dds), "shiny.appobj")
})
