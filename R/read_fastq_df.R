#' Read a Fastq file and store it as a dataframe
#'
#' This function reads a Fastq file and stores it as a dataframe with three columns: Header, Sequence, and QualityScore.
#'
#' @param fastq_file A character string specifying the path to the Fastq file to be read.
#'
#' @return This function returns a dataframe with three columns: Header, Sequence, and QualityScore.
#'
#' @examples
#'
#' sample_file_path_two <- system.file("extdata", "sample_fq.fastq", package = "baseq")
#'
#' read.fastq_to_df(sample_file_path_two)
#'
#' @export
read.fastq_to_df <- function(fastq_file) {
  # Extract file name without extension
  file_name <- sub("\\.fastq$", "", basename(fastq_file))

  # Open the fastq file
  con <- file(fastq_file, "r")

  # Initialize an empty dataframe
  df <- data.frame(Header=character(),
                   Sequence=character(),
                   QualityScore=character(),
                   stringsAsFactors=FALSE)

  # Loop over the fastq file, reading in four lines at a time
  while (length(header <- readLines(con, n=1)) > 0) {
    # Remove @ symbol from header
    header <- gsub("^@", "", header)
    
    sequence <- readLines(con, n=1)
    plus_line <- readLines(con, n=1)
    quality_scores <- readLines(con, n=1)

    # Add the four lines to the dataframe
    df <- rbind(df, data.frame(Header=header,
                               Sequence=sequence,
                               QualityScore=quality_scores,
                               stringsAsFactors=FALSE))
  }

  # Close the file and assign the dataframe to the environment
  close.connection(con)
  assign(file_name, df, parent.frame())

  # Print a message indicating successful assignment
  cat(sprintf("File %s assigned as a dataframe with name %s\n", fastq_file, file_name))
}
