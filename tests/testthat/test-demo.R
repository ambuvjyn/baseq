test_that("Full package workflow works", {
  # 1. Simulate DNA
  dna <- simulate_sequence(100, gc = 0.5)
  expect_equal(nchar(dna), 100)
  
  # 2. Clean & Transcribe
  cleaned <- clean_seq(dna)
  rna <- dna_to_rna(cleaned)
  expect_equal(nchar(rna), 100)
  
  # 3. Translate
  prots <- dna_to_protein(cleaned)
  expect_type(prots, "list")
  
  # 4. Wet-lab stats
  tm <- calculate_tm(substr(cleaned, 1, 20))
  expect_true(tm > 0)
  
  mw <- calculate_mw("MKF")
  expect_equal(mw, 424.54)
  
  # 5. File I/O
  tmp <- tempfile(fileext = ".fasta")
  df <- data.frame(Header="S1", Sequence=cleaned, stringsAsFactors=F)
  write_seq(df, tmp)
  res <- read_seq(tmp)
  expect_equal(res$Sequence[1], cleaned)
  
  # 6. Summary
  report <- summarize_fasta(tmp)
  expect_s3_class(report, "data.frame")
  expect_equal(nrow(report), 1)
  
  unlink(tmp)
})
