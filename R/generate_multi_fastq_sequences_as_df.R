#' Generate multiple FASTQ sequences as a data frame
#'
#' This function generates a specified number of FASTQ sequences with a specified sequence length and returns them as a data frame.
#'
#' @param num_seq Number of sequences to generate.
#' @param seq_length Length of the sequences to generate.
#' @return A data frame containing the generated FASTQ sequences.
#'
#' @examples
#' generate_multi_fastq_sequences_as_df(5, 20)
#'
#' @export
generate_multi_fastq_sequences_as_df <- function(num_seq, seq_length) {
  # Generate a list of FASTQ sequences
  fastq_list <- lapply(paste0("seq_", 1:num_seq), function(seq_name) {
    dna_seq <- paste0(sample(c("A", "C", "T", "G"), seq_length, replace = TRUE), collapse = "")
    quality_score <- paste0(sample(c(0:9, "A", "B", "C", "D", "E", "F"), seq_length, replace = TRUE), collapse = "")
    list(Header = seq_name, Sequence = dna_seq, QualityScore = quality_score)
  })

  # Convert the list to a data frame
  fastq_df <- as.data.frame(do.call(rbind, fastq_list), stringsAsFactors = FALSE)

  # Reorder the columns
  fastq_df <- fastq_df[, c("Header", "Sequence", "QualityScore")]

  # Return the resulting data frame
  return(fastq_df)
}
