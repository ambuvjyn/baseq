#' Generate Multiple Protein Sequences as a Data Frame
#'
#' This function generates multiple random Protein sequences of a specified length and returns them as a data frame.
#'
#' @param num_seq the number of Protein sequences to generate
#' @param seq_length the length of each Protein sequence
#'
#' @return a data frame with two columns: "Header" and "Sequence"
#'
#' @examples
#' generate_multi_protein_sequences_as_df(5, 50)
#'
#' @export
generate_multi_protein_sequences_as_df <- function(num_seq, seq_length) {
  # generate a list of Protein sequences
  protein_list <- lapply(paste0("seq_", 1:num_seq), function(seq_name) {
    protein_seq <- paste0(sample(c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"), seq_length, replace = TRUE), collapse = "")
    list(seq_name = protein_seq)
  })

  # convert the list to a data frame
  protein_df <- as.data.frame(do.call(rbind, protein_list), stringsAsFactors = FALSE)

  # add a column for the sequence headers
  protein_df$Header <- paste0("seq_", 1:num_seq)

  # reorder the columns
  protein_df <- protein_df[, c("Header", "seq_name")]

  # rename the sequence column to "Sequence"
  colnames(protein_df) <- c("Header", "Sequence")

  # return the resulting data frame
  return(protein_df)
}
