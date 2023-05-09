#' Write a list of sequence_bases and quality scores to a FASTQ file
#'
#' This function takes a list of sequence_bases and quality scores and writes them to a FASTQ file.
#' The name of the list is used as the base name for the output file with the .fastq extension.
#' Each sequence in the list is written to the output file in FASTQ format with the sequence
#' name as the header and the quality scores on the following line.
#'
#' @param sequence_list A list of sequence_bases where each element of the list is a named list
#'                      containing "Sequence" and "QualityScore" elements.
#'
#' @param output_dir The directory path where the output file should be written. If not provided, the working directory will be used.
#'
#' @examples
#' sequence_bases <- list("ACGT", "ATCG")
#' quality_scores <- list("IIII", "JJJJ")
#' sequences <- list(seq1=list(Sequence=sequence_bases[[1]], QualityScore=quality_scores[[1]]),
#'                        seq2=list(Sequence=sequence_bases[[2]], QualityScore=quality_scores[[2]]))
#' tempdir <- tempdir()
#' write.list_to_fastq(sequences, output_dir = tempdir)
#'
#' # Write to working directory
#' # write.list_to_fastq(sequences)
#'
#' # Write to custom directory
#' # write.list_to_fastq(sequences, output_dir = "/path/to/directory/")
#'
#' @export
write.list_to_fastq <- function(sequence_list, output_dir=getwd()) {
  # Get the list name
  list_name <- deparse(substitute(sequence_list))

  # Set the output file name as the list name with the .fasta extension
  output_file <- file.path(output_dir, paste0(list_name, ".fastq"))

  # Open the output file for writing
  con <- file(output_file, "w")

  # Loop over the list elements and write each sequence to the file in FASTQ format
  for (i in seq_along(sequence_list)) {
    seq_name <- names(sequence_list)[i]
    sequence <- sequence_list[[seq_name]]$Sequence
    quality_score <- sequence_list[[seq_name]]$QualityScore
    writeLines(sprintf("@%s", seq_name), con)
    writeLines(sequence, con)
    writeLines(sprintf("+%s", seq_name), con)
    writeLines(quality_score, con)
  }

  # Close the output file
  close.connection(con)

  # Print a message indicating successful write
  cat(sprintf("List %s written to FASTQ file %s\n", list_name, output_file))
}
