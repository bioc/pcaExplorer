test_that("Gene profiler does its job properly", {
  geneprofiler(rlt, paste0("gene", sample(1:1000, 20)))
  
  expect_error(
    expect_message(
      geneprofiler(rlt, "gene_fake")
    )
  )
})

test_that("Distribution of expression", {
  p <- distro_expr(rlt)
  expect_true(is(p, "gg"))
})

test_that("Correlation scatter plot matrix works", {
  pair_corr(counts(dds)[1:100, ])
  expect_error(pair_corr(dds))
})
