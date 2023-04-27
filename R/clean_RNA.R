#' Clean RNA file
#'
#' This function reads a multi FASTA file containing RNA sequences, removes any characters other
#' than A, T, G, and C, and writes the cleaned sequences to a new multi FASTA file. The output
#' file name is generated from the input file name with the suffix '_clean.fasta'.
#'
#' @param input_file The name of the input multi FASTA file.
#' @param output_dir The directory where the output file will be saved. If not given,
#' the output file will be saved in the same directory as the input file.
#' @return A character string specifying the path to the output FASTA file.
#'
#' @examples
#' sample_file_path_three <- system.file("extdata", "sample2_fa.fasta", package = "baseq")
#' tempdir <- tempdir()
#' temp_file_path <- file.path(tempdir, basename(sample_file_path_three))
#' file.copy(sample_file_path_three, temp_file_path, overwrite = TRUE)
#' clean_RNA_file(temp_file_path, output_dir = tempdir)
#'
#' # Write to working directory
#' # clean_RNA_file(file_path)
#'
#' # Write to custom directory
#' # clean_RNA_file(file_path, output_dir = "/path/to/directory/")
#'
#' @export
clean_RNA_file <- function(input_file, output_dir = "") {
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
    gsub("[^AUGC]", "", seq)
  })

  # Write cleaned sequences to output file
  con <- file(output_file, "w")
  for (i in 1:length(clean_seq_list)) {
    seq_name <- names(clean_seq_list)[i]
    seq_string <- clean_seq_list[[i]]
    writeLines(paste0(">", seq_name), con)
    writeLines(seq_string, con)
  }
  close.connection(con)

  # Print message
  cat(paste0("Cleaned sequences written to file '", output_file, "'.\n"))

  return(output_file)
}
