#' Generate Multiple RNA Sequences as a Data Frame
#'
#' This function generates multiple random RNA sequences of a specified length and returns them as a data frame.
#'
#' @param num_seq the number of RNA sequences to generate
#' @param seq_length the length of each RNA sequence
#'
#' @return a data frame with two columns: "Header" and "Sequence"
#'
#' @examples
#' generate_multi_rna_sequences_as_df(5, 50)
#'
#' @export
generate_multi_rna_sequences_as_df <- function(num_seq, seq_length) {
  # generate a list of RNA sequences
  rna_list <- lapply(paste0("seq_", 1:num_seq), function(seq_name) {
    rna_seq <- paste0(sample(c("A", "C", "G", "U"), seq_length, replace = TRUE), collapse = "")
    list(seq_name = rna_seq)
  })

  # convert the list to a data frame
  rna_df <- as.data.frame(do.call(rbind, rna_list), stringsAsFactors = FALSE)

  # add a column for the sequence headers
  rna_df$Header <- paste0("seq_", 1:num_seq)

  # reorder the columns
  rna_df <- rna_df[, c("Header", "seq_name")]

  # rename the sequence column to "Sequence"
  colnames(rna_df) <- c("Header", "Sequence")

  # return the resulting data frame
  return(rna_df)
}
