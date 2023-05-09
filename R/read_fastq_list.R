#' Read a Fastq file and store it as a list
#'
#' This function reads a Fastq file and stores it as a list with three columns: Header, Sequence, and QualityScore.
#'
#' @param fastq_file A character string specifying the path to the Fastq file to be read.
#'
#' @return This function returns a list with three columns: Header, Sequence, and QualityScore.
#'
#' @examples
#' \donttest{
#' # Read in sequences from a FASTQ file
#'
#' sample_file_path_two <- system.file("extdata", "sample_fq.fastq", package = "baseq")
#' read.fastq_to_list(sample_file_path_two)
#' }
#' @export
read.fastq_to_list <- function(fastq_file) {
  # Extract file name without extension
  file_name <- sub("\\.fastq$", "", basename(fastq_file))

  # Open the fastq file
  con <- file(fastq_file, "r")

  # Initialize an empty list
  sequences <- list()

  # Loop over the fastq file, reading in four lines at a time
  while (length(header <- readLines(con, n=1)) > 0) {
    # Remove @ symbol from header
    header <- gsub("^@", "", header)

    sequence <- readLines(con, n=1)
    plus_line <- readLines(con, n=1)
    quality_scores <- readLines(con, n=1)

    # Add the sequence to the list with the header as the list element name
    sequences[[header]] <- list(Sequence=sequence, QualityScore=quality_scores)
  }

  # Close the file and assign the list to the environment
  close(con)
  assign(file_name, sequences, parent.frame())

  # Print a message indicating successful assignment
  cat(sprintf("File %s assigned as a list with name %s\n", fastq_file, file_name))
}
