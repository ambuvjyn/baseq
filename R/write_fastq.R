#' Write dataframe or list to FASTQ file
#'
#' This function takes as input a dataframe or list and writes it to a FASTQ file format.
#'
#' @param input A dataframe or list containing sequence data
#' @param output_dir A string specifying the directory where the output file will be written (default is the current working directory)
#'
#' @return This function does not return anything, but writes the input to a FASTQ file
#'
#' @examples
#' # Write a dataframe to a FASTQ file
#' # write.fastq(df, "output_directory")
#'
#' # Write a list to a FASTQ file
#' # write.fastq(sequence_list, "output_directory")
#'
#' @export
write.fastq <- function(input, output_dir = getwd()) {

  # Identify whether the input is a dataframe or a list
  if (is.data.frame(input)) {
    # Get the name of the dataframe
    input_name <- deparse(substitute(input))

    # Get the name of the output file
    output_file <- file.path(output_dir, paste0(input_name, ".fastq"))

    # Open the output file for writing
    con <- file(output_file, "w")

    # Loop over the dataframe and write each read to the output file
    for (i in 1:nrow(input)) {
      header <- paste0("@", input[i, "Header"])
      sequence <- input[i, "Sequence"]
      quality_score <- input[i, "QualityScore"]
      writeLines(header, con)
      writeLines(sequence, con)
      writeLines("+", con)
      writeLines(quality_score, con)
    }

    # Close the output file
    close(con)

    # Print a message indicating successful writing
    cat(sprintf("Dataframe %s written to FASTQ file %s\n", input_name, output_file))
  } else if (is.list(input)) {
    # Get the list name
    input_name <- deparse(substitute(input))

    # Set the output file name as the list name with the .fastq extension
    output_file <- file.path(output_dir, paste0(input_name, ".fastq"))

    # Open the output file for writing
    con <- file(output_file, "w")

    # Loop over the list elements and write each sequence to the file in FASTQ format
    for (i in seq_along(input)) {
      seq_name <- names(input)[i]
      sequence <- input[[seq_name]]$Sequence
      quality_score <- input[[seq_name]]$QualityScore
      writeLines(sprintf("@%s", seq_name), con)
      writeLines(sequence, con)
      writeLines(sprintf("+%s", seq_name), con)
      writeLines(quality_score, con)
    }

    # Close the output file
    close(con)

    # Print a message indicating successful write
    cat(sprintf("List %s written to FASTQ file %s\n", input_name, output_file))
  } else {
    stop("Input must be either a dataframe or a list")
  }
}

#' @rdname write.fasta
#' @export
write_fasta <- write.fasta
