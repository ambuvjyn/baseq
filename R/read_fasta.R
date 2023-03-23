#' Read sequences from a FASTA file
#'
#' This function reads in a FASTA file and returns a list of sequences,
#' where each sequence is associated with its sequence name.
#'
#' @param file_path The path to the FASTA file to read in.
#'
#' @return A list of sequences, where each sequence is associated with its
#'         sequence name.
#'
#' @examples
#' \donttest{
#' # Read in sequences from a FASTA file
#'
#' sample_file_path <- system.file("extdata", "sample.fasta", package = "baseq")
#'
#' seqs <- read.fasta(sample_file_path)
#'
#' # Access a specific sequence by name
#' seqs[["sequence_name"]]
#' }
#' @export
read.fasta <- function(file_path) {
  # Open the file and read the contents
  file_con <- file(file_path, "r")
  file_contents <- readLines(file_con)
  close(file_con)

  # Initialize empty variables for storing sequence data
  sequences <- list()
  current_seq_name <- NULL
  current_seq <- ""

  # Parse the contents of the file line by line
  for (line in file_contents) {
    if (substr(line, 1, 1) == ">") {
      # This is a header line indicating a new sequence
      if (!is.null(current_seq_name)) {
        # If we have already read in a sequence, store it in the list
        sequences[[current_seq_name]] <- current_seq
        current_seq <- ""
      }
      current_seq_name <- sub("^>(\\S+).*", "\\1", line) # Remove the ">" character
    } else {
      # This is a line of sequence data
      current_seq <- paste(current_seq, line, sep="")
    }
  }
  # Store the final sequence
  sequences[[current_seq_name]] <- current_seq

  # Return the list of sequences
  return(sequences)
}
