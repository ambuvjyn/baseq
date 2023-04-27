#' Write a list of sequences to a FASTA file
#'
#' This function takes a list of sequences and writes them to a FASTA file. The name of the list
#' is used as the base name for the output file with the .fasta extension. Each sequence in the
#' list is written to the output file in FASTA format with the sequence name as the header.
#'
#' @param sequence_list A list of sequences where each element of the list is a character string
#' representing a single sequence.
#'
#' @param output_dir The directory path where the output file should be written. If not provided, the working directory will be used.
#'
#' @examples
#' sequences <- list("ACGT", "ATCG")
#' tempdir <- tempdir()
#' write.list_to_fasta(sequences, output_dir = tempdir)
#'
#' # Write to working directory
#' # write.list_to_fasta(sequences)
#'
#' # Write to custom directory
#' # write.list_to_fasta(sequences, output_dir = "/path/to/directory/")
#'
#' @export
write.list_to_fasta <- function(sequence_list, output_dir=getwd()) {
  # Get the list name
  list_name <- deparse(substitute(sequence_list))

  # Set the output file name as the list name with the .fasta extension
  output_file <- file.path(output_dir, paste0(list_name, ".fasta"))

  # Open the output file for writing
  con <- file(output_file, "w")

  # Loop over the list elements and write each sequence to the file in FASTA format
  for (i in seq_along(sequence_list)) {
    seq_name <- paste0("seq", i)
    sequence <- sequence_list[[i]]
    writeLines(sprintf(">%s", seq_name), con)
    writeLines(sequence, con)
  }

  # Close the output file
  close(con)

  # Print a message indicating successful write
  cat(sprintf("List %s written to FASTA file %s\n", list_name, output_file))
}
