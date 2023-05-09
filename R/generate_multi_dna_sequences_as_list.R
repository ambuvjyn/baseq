#' Generate multiple DNA sequences as a list
#'
#' @param num_seq The number of DNA sequences to generate.
#' @param seq_length The length of each DNA sequence.
#' @return A list of DNA sequences.
#' @examples
#' generate_multi_dna_sequences_as_list(10, 50)
#'
#' @export
generate_multi_dna_sequences_as_list <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    dna_seq <- paste0(sample(c("A", "C", "G", "T"), seq_length, replace=TRUE), collapse="")
    list(dna_seq)
  })
  names(seqs) <- paste0("seq_", 1:num_seq)
  return(seqs)
}
