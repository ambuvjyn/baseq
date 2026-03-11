test_that("Universal cleaner works", {
  expect_equal(clean_seq("atgcN"), "ATGC")
  expect_equal(clean_seq("augcN"), "AUGC")
  expect_equal(clean_seq(NA), "")
  expect_equal(clean_seq(NULL), "")
})

test_that("Universal reverse complement works", {
  expect_equal(rev_comp("ATGC"), "GCAT")
  expect_equal(rev_comp("AUGC"), "GCAU")
})

test_that("Quality filter works", {
  tmpq <- tempfile(fileext = ".fastq"); tmpout <- tempfile(fileext = ".fastq")
  writeLines(c("@H1", "ATGC", "+", "!!!!"), tmpq) # Low quality
  filter_fastq_quality(tmpq, tmpout, min_avg_quality = 20)
  expect_equal(nrow(read_seq(tmpout)), 0)
  unlink(tmpq); unlink(tmpout)
})
