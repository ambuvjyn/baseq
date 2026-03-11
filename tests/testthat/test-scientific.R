test_that("Core scientific functions work", {
  # Translation
  expect_equal(dna_to_protein("ATG")$`Frame F1`, "M")
  
  # Stats
  expect_equal(gc_content("GCAT"), 50)
  
  # Wet-lab
  expect_equal(calculate_tm("ATGCATGC"), 24)
  expect_equal(calculate_mw("MKF"), 424.54)
  expect_equal(calculate_pi("RHK"), 11.00)
  expect_equal(calculate_charge("RHK", ph=1), 3.997)
  
  # Discovery
  expect_equal(find_longest_orf("ATGGCCATTGTAATGGGCCGCTGAAAGGGTGCCCGATAG"), "MAIVMGR")
  expect_equal(nrow(search_motif("ATGC", "ATG")), 1)
})

test_that("Assembly and K-mer stats work", {
  expect_equal(unname(calculate_assembly_stats(c("A","AA"))["Total"]), 3)
  expect_equal(as.vector(count_kmers("ATGC", k=2)["AT"]), 1)
})
