#' Clean protein sequences from a file and save to a new file
#'
#' This function reads in a file of protein sequences in FASTA format, removes any non-amino acid characters, and saves the cleaned sequences to a new file.
#'
#' @param input_file character string specifying the path to the input file of protein sequences in FASTA format.
#' @param output_dir character string specifying the directory where the cleaned sequences file should be saved. Defaults to the same directory as the input file.
#'
#' @return A character string specifying the path to the file where the cleaned sequences have been saved.
#'
#' @examples
#' # clean_protein_file("path/to/input/file.fasta", output_dir = "path/to/output/directory")
#'
#' @export
clean_protein_file <- function(input_file, output_dir = "") {
  # Open input file
  con <- file(input_file, "r")

  # Initialize variables
  if (output_dir == "") {
    output_dir <- dirname(input_file)
  }
  output_file <- file.path(output_dir, paste0(basename(tools::file_path_sans_ext(input_file)), "_clean.fasta"))
  seq_list <- list()
  seq_name <- NULL
  seq_string <- NULL

  # Read lines from input file
  while (length(line <- readLines(con, n = 1, warn = FALSE)) > 0) {
    if (substr(line, 1, 1) == ">") {
      # Header line
      if (!is.null(seq_name) && !is.null(seq_string)) {
        # Add previous sequence to list
        seq_list[[seq_name]] <- seq_string
      }
      # Start new sequence
      seq_name <- substring(line, 2)
      seq_string <- ""
    } else {
      # Sequence line
      seq_string <- paste0(seq_string, line)
    }
  }
  # Add last sequence to list
  seq_list[[seq_name]] <- seq_string

  # Close input file
  close(con)

  # Clean sequences
  clean_seq_list <- lapply(seq_list, function(seq) {
    seq <- toupper(seq)
    gsub("[^ACDEFGHIKLMNPQRSTVWY]", "", seq)
  })

  # Write cleaned sequences to output file
  con <- file(output_file, "w")
  for (i in 1:length(clean_seq_list)) {
    seq_name <- names(clean_seq_list)[i]
    seq_string <- clean_seq_list[[i]]
    writeLines(paste0(">", seq_name), con)
    writeLines(seq_string, con)
  }
  close(con)

  # Print message
  cat(paste0("Cleaned sequences written to file '", output_file, "'.\n"))

  return(output_file)
}
