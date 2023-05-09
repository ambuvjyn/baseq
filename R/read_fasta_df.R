#' Read a fasta file into a dataframe and assign to the environment
#'
#' This function reads a fasta file and creates a dataframe with two columns:
#' Header and Sequence. The dataframe is then assigned to the environment with the
#' name same as the fasta file name but without the .fasta extension.
#'
#' @param fasta_file The path to the fasta file to be read.
#'
#' @return This function does not return anything. It assigns the resulting dataframe
#' to the environment.
#'
#' @examples
#' \donttest{
#' # Read in sequences from a FASTA file
#'
#' sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' read.fasta_to_df(sample_file_path)
#' }
#'
#' @export
read.fasta_to_df <- function(fasta_file) {
  # Open the fasta file
  con <- file(fasta_file, "r")

  # Get the file name without extension
  file_name <- sub("\\.fasta$", "", basename(fasta_file))

  # Initialize an empty dataframe
  df <- data.frame(Header=character(),
                   Sequence=character(),
                   stringsAsFactors=FALSE)

  # Loop over the fasta file, reading in header and sequence lines
  while (length(header <- readLines(con, n=1)) > 0) {
    # Remove the ">" symbol from the header line
    header <- gsub(">", "", header, fixed = TRUE)
    sequence <- readLines(con, n=1)

    # Add the header and sequence lines to the dataframe
    df <- rbind(df, data.frame(Header=header,
                               Sequence=sequence,
                               stringsAsFactors=FALSE))
  }

  # Close the file and assign the dataframe to the environment
  close(con)
  assign(file_name, df, envir = parent.frame())

  # Print a message indicating successful assignment
  cat(sprintf("File %s assigned as a dataframe with name %s\n", fasta_file, file_name))
}
