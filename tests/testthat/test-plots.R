test_that("Plotting functions return ggplot objects", {
  skip_if_not_installed("ggplot2")
  s <- "ATGCATGCATGCATGC"
  expect_s3_class(plot_gc_skew(paste0(s,s,s,s,s,s,s,s)), "ggplot")
  expect_s3_class(plot_aa_composition("MKFLVLALAL"), "ggplot")
  expect_s3_class(plot_hydrophobicity("MKFLVLALAL", window=3), "ggplot")
  expect_s3_class(plot_dotplot("ATGC", "ATGC"), "ggplot")
})
