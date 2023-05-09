#' Generate multiple RNA sequences
#'
#' This function generates a specified number of RNA sequences with random bases.
#'
#' @param num_seq An integer specifying the number of RNA sequences to generate.
#' @param seq_length An integer specifying the length of each RNA sequence.
#'
#' @return A character vector of RNA sequences in FASTA format.
#'
#' @examples
#' generate_multi_rna_sequences(3, 10)
#'
#' @export
generate_multi_rna_sequences <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    rna_seq <- paste0(sample(c("A", "C", "G", "U"), seq_length, replace=TRUE), collapse="")
    paste0(">", seq_name, "\n", rna_seq)
  })
  cat(seqs, sep="\n")
}
