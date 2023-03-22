#' Write a list of sequences to a FASTA file
#'
#' This function takes a list of sequences and writes them to a FASTA file. The name of the list
#' is used as the base name for the output file with the .fasta extension. Each sequence in the
#' list is written to the output file in FASTA format with the sequence name as the header.
#'
#' @param sequence_list A list of sequences where each element of the list is a character string
#' representing a single sequence.
#'
#' @examples
#' sequences <- list("ACGT", "ATCG")
#' write.list_to_fasta(sequences)
#'
#' @export
write.list_to_fasta <- function(sequence_list) {
  # Get the list name
  list_name <- deparse(substitute(sequence_list))
  
  # Set the output file name as the list name with the .fasta extension
  output_file <- paste0(list_name, ".fasta")
  
  # Open the output file for writing
  con <- file(output_file, "w")
  
  # Loop over the list elements and write each sequence to the file in FASTA format
  for (seq_name in names(sequence_list)) {
    sequence <- sequence_list[[seq_name]]
    writeLines(sprintf(">%s", seq_name), con)
    writeLines(sequence, con)
  }
  
  # Close the output file
  close.connection(con)
  
  # Remove the temp file
  file.remove("sequences.fasta")
  
  # Print a message indicating successful write
  cat(sprintf("List %s written to FASTA file %s\n", list_name, output_file))
}
