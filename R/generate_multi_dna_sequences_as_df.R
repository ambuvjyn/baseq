#' Generate Multiple DNA Sequences as a Data Frame
#'
#' This function generates multiple random DNA sequences of a specified length and returns them as a data frame.
#'
#' @param num_seq the number of DNA sequences to generate
#' @param seq_length the length of each DNA sequence
#'
#' @return a data frame with two columns: "Header" and "Sequence"
#'
#' @examples
#' generate_multi_dna_sequences_as_df(5, 50)
#'
#' @export
generate_multi_dna_sequences_as_df <- function(num_seq, seq_length) {
  # generate a list of DNA sequences
  dna_list <- lapply(paste0("seq_", 1:num_seq), function(seq_name) {
    dna_seq <- paste0(sample(c("A", "C", "G", "T"), seq_length, replace = TRUE), collapse = "")
    list(seq_name = dna_seq)
  })

  # convert the list to a data frame
  dna_df <- as.data.frame(do.call(rbind, dna_list), stringsAsFactors = FALSE)

  # add a column for the sequence headers
  dna_df$Header <- paste0("seq_", 1:num_seq)

  # reorder the columns
  dna_df <- dna_df[, c("Header", "seq_name")]

  # rename the sequence column to "Sequence"
  colnames(dna_df) <- c("Header", "Sequence")

  # return the resulting data frame
  return(dna_df)
}
