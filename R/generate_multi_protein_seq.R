#' Generate Multiple Protein Sequences
#'
#' This function generates multiple protein sequences of specified length.
#'
#' @param num_seq An integer specifying the number of protein sequences to generate.
#' @param seq_length An integer specifying the length of each protein sequence.
#'
#' @return This function returns a character vector containing the generated protein sequences.
#'
#' @examples
#' generate_multi_protein_sequences(3, 10)
#'
#' @export
generate_multi_protein_sequences <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    protein_seq <- paste0(sample(c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"), seq_length, replace=TRUE), collapse="")
    paste0(">", seq_name, "\n", protein_seq)
  })
  cat(seqs, sep="\n")
}
