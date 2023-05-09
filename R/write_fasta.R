#' Write fasta file
#'
#' This function writes a fasta file from either a data frame or a list of sequences.
#'
#' @param sequences A data frame or a list of sequences to be written to a fasta file.
#' @param output_dir The directory where the output fasta file will be saved. Default is the current working directory.
#'
#' @details
#' If the input object is a data frame, the function expects the data frame to have two columns named "Header" and "Sequence". The function will write each record to the fasta file.
#'
#' If the input object is a list, the function will loop over the list elements and write each sequence to the file in FASTA format in the format.
#'
#' @examples
#' # Write fasta file from a data frame
#' # df <- data.frame(Header = c("seq1", "seq2"), Sequence = c("ATCGATCG", "CGATCGAT"))
#' # write_fasta(df)
#'
#' # Write fasta file from a list
#' # seq_list <- list("ATCGATCG", "CGATCGAT")
#' # write_fasta(seq_list)
#'
#' @export
write.fasta <- function(sequences, output_dir = getwd()) {
  # Get the name of the input object
  obj_name <- deparse(substitute(sequences))

  # Set the output file name as the input object name with the .fasta extension
  output_file <- file.path(output_dir, paste0(obj_name, ".fasta"))

  # Open the output file for writing
  con <- file(output_file, "w")

  # Check the class of the input object and write sequences accordingly
  if (is.data.frame(sequences)) {
    # Write each record to the fasta file
    for (i in 1:nrow(sequences)) {
      header <- paste0(">", sequences$Header[i])
      sequence <- sequences$Sequence[i]
      writeLines(c(header, sequence), con)
    }
    cat(sprintf("Data frame %s written to fasta file %s\n", obj_name, output_file))
  } else if (is.list(sequences)) {
    # Loop over the list elements and write each sequence to the file in FASTA format
    for (i in seq_along(sequences)) {
      seq_name <- paste0("seq", i)
      sequence <- sequences[[i]]
      writeLines(sprintf(">%s", seq_name), con)
      writeLines(sequence, con)
    }
    cat(sprintf("List %s written to FASTA file %s\n", obj_name, output_file))
  } else {
    stop("Input object must be either a data frame or a list.")
  }

  # Close the output file
  close.connection(con)
}


#' @rdname write.fasta
#' @export
write_fasta <- write.fasta
