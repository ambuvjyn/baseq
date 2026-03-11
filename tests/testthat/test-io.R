test_that("Universal reader and writer work", {
  tmp <- tempfile(fileext = ".fasta")
  df <- data.frame(Header="S1", Sequence="ATGC", stringsAsFactors=F)
  write_seq(df, tmp)
  
  res <- read_seq(tmp, format="df")
  expect_equal(res$Sequence[1], "ATGC")
  
  res_l <- read_seq(tmp, format="list")
  expect_equal(res_l$S1, "ATGC")
  unlink(tmp)
})

test_that("FASTQ to FASTA conversion works", {
  tmpq <- tempfile(fileext = ".fastq")
  writeLines(c("@H1", "ATGC", "+", "IIII"), tmpq)
  
  out <- fastq_to_fasta(tmpq)
  expect_true(file.exists(out))
  
  res <- read_seq(out)
  expect_equal(res$Sequence[1], "ATGC")
  unlink(tmpq); unlink(out)
})
