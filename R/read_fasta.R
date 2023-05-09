#' Read a FASTA file as a dictionary
#'
#' This function reads a FASTA file as a character vector and returns a list
#' where each key is a sequence identifier and the corresponding value is the
#' sequence itself.
#'
#' @param file_path The path to the FASTA file.
#'
#' @return A list where each key is a sequence identifier and the corresponding
#' value is the sequence itself.
#'
#' @examples
#' # fasta_dict <- read_fasta("path/to/your/fasta/file.fasta")
#' # seq1 <- fasta_dict[["sequence1"]]
#'
#' @export
read.fasta <- function(file_path) {
  # Read the FASTA file as a character vector
  fasta_lines <- readLines(file_path)

  # Initialize variables
  seq_name <- NULL
  seq_string <- NULL
  seq_dict <- list()

  # Loop through each line in the character vector
  for (line in fasta_lines) {
    if (substr(line, 1, 1) == ">") {
      # Header line
      if (!is.null(seq_name) && !is.null(seq_string)) {
        # Add previous sequence to dictionary
        seq_dict[[seq_name]] <- seq_string
      }
      # Start new sequence
      seq_name <- substring(line, 2)
      seq_string <- ""
    } else {
      # Sequence line
      seq_string <- paste0(seq_string, line)
    }
  }
  # Add last sequence to dictionary
  seq_dict[[seq_name]] <- seq_string

  return(seq_dict)
}

#' @rdname read.fasta
#' @export
read_fasta <- read.fasta
