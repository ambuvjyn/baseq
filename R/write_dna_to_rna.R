#' Convert DNA file to RNA file
#'
#' This function reads a multi FASTA file containing DNA sequences, converts each DNA sequence to RNA sequence,
#' and writes the RNA sequences to a new multi FASTA file. The output file name is generated from the input file
#' name with the suffix '_rna.fasta'.
#'
#' @param input_file The name of the input multi FASTA file.
#' @param output_dir The directory where the output file will be saved. If not given,
#' the output file will be saved in the same directory as the input file.
#' @return A character string specifying the path to the output FASTA file.
#'
#' @examples
#' #sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' #tempdir <- tempdir()
#' #temp_file_path <- file.path(tempdir, basename(sample_file_path))
#' #file.copy(sample_file_path, temp_file_path, overwrite = TRUE)
#' #write.dna_to_rna(temp_file_path, output_dir = tempdir)
#'
#' # Write to working directory
#' # write.dna_to_rna(file_path)
#'
#' # Write to custom directory
#' # write.dna_to_rna(file_path, output_dir = "/path/to/directory/")
#'
#' @export
write.dna_to_rna <- function(input_file, output_dir = "") {
  # Open input file
  con <- file(input_file, "r")

  # Initialize variables
  if (output_dir == "") {
    output_dir <- dirname(input_file)
  }
  output_file <- file.path(output_dir, paste0(basename(tools::file_path_sans_ext(input_file)), "_rna.fasta"))
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
  close.connection(con)

  # Convert DNA sequences to RNA sequences
  rna_seq_list <- lapply(seq_list, function(seq) {
    gsub("T", "U", seq)
  })

  # Write RNA sequences to output file
  con <- file(output_file, "w")
  for (i in 1:length(rna_seq_list)) {
    seq_name <- names(rna_seq_list)[i]
    seq_string <- rna_seq_list[[i]]
    writeLines(paste0(">", seq_name), con)
    writeLines(seq_string, con)
  }
  close.connection(con)

  # Print message
  cat(paste0("RNA sequences written to file '", output_file, "'.\n"))

  return(output_file)
}
