#' Read a fasta file into a list and assign to the environment
#'
#' This function reads a fasta file and creates a list with two columns:
#' Header and Sequence. The list is then assigned to the environment with the
#' name same as the fasta file name but without the .fasta extension.
#'
#' @param fasta_file The path to the fasta file to be read.
#'
#' @return This function does not return anything. It assigns the resulting list
#' to the environment.
#'
#' @examples
#' \donttest{
#' # Read in sequences from a FASTA file
#'
#' sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' read.fasta_to_list(sample_file_path)
#' }
#' # Access a specific sequence by name
#' # sample_fa[["sample_seq.1"]]
#'
#' @export
read.fasta_to_list <- function(fasta_file) {
  # Open the fasta file
  con <- file(fasta_file, "r")

  # Get the file name without extension
  file_name <- sub("\\.fasta$", "", basename(fasta_file))

  # Initialize an empty list
  sequences <- list()

  # Loop over the fasta file, reading in header and sequence lines
  while (length(header <- readLines(con, n=1)) > 0) {
    # Extract the sequence name from the header line
    seq_name <- gsub(">", "", header, fixed = TRUE)
    sequence <- readLines(con, n=1)

    # Add the sequence to the list with the sequence name as the list element name
    sequences[[seq_name]] <- sequence
  }

  # Close the file and assign the list to the environment
  close(con)
  assign(file_name, sequences, envir = parent.frame())

  # Print a message indicating successful assignment
  cat(sprintf("File %s assigned as a list with name %s\n", fasta_file, file_name))
}
