#' Write a list of sequences and quality scores to a FASTQ file
#'
#' This function takes a list of sequences and quality scores and writes them to a FASTQ file.
#' The name of the list is used as the base name for the output file with the .fastq extension.
#' Each sequence in the list is written to the output file in FASTQ format with the sequence 
#' name as the header and the quality scores on the following line.
#'
#' @param sequence_list A list of sequences where each element of the list is a named list 
#'                      containing "Sequence" and "QualityScore" elements.
#'
#' @examples
#' sequences <- list("ACGT", "ATCG")
#' quality_scores <- list("IIII", "JJJJ")
#' sequences_list <- list(seq1=list(Sequence=sequences[[1]], QualityScore=quality_scores[[1]]),
#'                        seq2=list(Sequence=sequences[[2]], QualityScore=quality_scores[[2]]))
#' write.list_to_fastq(sequences_list)
#'
#' @export
write.list_to_fastq <- function(sequence_list) {
  # Get the list name
  list_name <- deparse(substitute(sequence_list))
  
  # Set the output file name as the list name with the .fastq extension
  output_file <- paste0(list_name, ".fastq")
  
  # Open the output file for writing
  con <- file(output_file, "w")
  
  # Loop over the list elements and write each sequence to the file in FASTQ format
  for (seq_name in names(sequence_list)) {
    sequence <- sequence_list[[seq_name]]$Sequence
    quality_score <- sequence_list[[seq_name]]$QualityScore
    writeLines(sprintf("@%s", seq_name), con)
    writeLines(sequence, con)
    writeLines(sprintf("+%s", seq_name), con)
    writeLines(quality_score, con)
  }
  
  # Close the output file
  close.connection(con)
  
  # Remove the temp file
  file.remove("sequences_list.fastq")
  
  # Print a message indicating successful write
  cat(sprintf("List %s written to FASTQ file %s\n", list_name, output_file))
}
