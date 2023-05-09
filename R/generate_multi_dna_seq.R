#' Generate multiple random DNA sequences
#'
#' This function generates a specified number of random DNA sequences of a specified length.
#'
#' @param num_seq The number of sequences to generate
#' @param seq_length The length of each sequence
#'
#' @return A character vector of DNA sequences in FASTA format
#'
#' @examples
#' generate_multi_dna_sequences(3, 10)
#'
#' @export
generate_multi_dna_sequences <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    dna_seq <- paste0(sample(c("A", "C", "G", "T"), seq_length, replace=TRUE), collapse="")
    paste0(">", seq_name, "\n", dna_seq)
  })
  cat(seqs, sep="\n")
}
