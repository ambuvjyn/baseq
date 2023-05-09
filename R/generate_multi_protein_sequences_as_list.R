#' Generate multiple protein sequences as a list
#'
#' @param num_seq The number of protein sequences to generate.
#' @param seq_length The length of each protein sequence.
#' @return A list of protein sequences.
#' @examples
#' generate_multi_protein_sequences_as_list(10, 50)
#'
#' @export
generate_multi_protein_sequences_as_list <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    protein_seq <- paste0(sample(c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"), seq_length, replace=TRUE), collapse="")
    list(protein_seq)
  })
  names(seqs) <- paste0("seq_", 1:num_seq)
  return(seqs)
}
