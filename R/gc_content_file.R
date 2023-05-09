#' GC content of sequences in a multi FASTA file
#'
#' Function to calculate GC content of sequences in a multi FASTA file
#' and write the results to a new FASTA file
#'
#' @param input_file A string indicating the path and name of the input multi-FASTA file
#'
#' @examples
#' #sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' #clean_DNA_file(sample_file_path)
#'
#' @export
gc_content_file <- function(input_file) {
  # Read in the multi-FASTA file
  fasta <- readLines(input_file)

  # Parse the sequence names and sequences from the input file
  names <- fasta[grep(">", fasta)]
  sequences <- fasta[-grep(">", fasta)]

  # Calculate the GC content for each sequence
  GC_content <- sapply(sequences, function(seq) {
    GC_count <- sum(unlist(strsplit(seq, "")) %in% c("G", "C"))
    return(GC_count / nchar(seq))
  })

  # Add the GC content to the sequence names
  names_with_GC <- paste0(names, "_GC_", round(GC_content, digits = 2) * 100, "%")

  # Write the output file
  output_file <- paste0(sub(".fasta", "", input_file), "_with_GC_content.fasta")
  con <- file(output_file, "w")
  for (i in seq_along(names)) {
    writeLines(paste0(names_with_GC[i], "\n", sequences[i]), con)
  }
  close.connection(con)

  # Print a message indicating successful write
  cat(sprintf("GC content calculated for sequences in %s and written to %s.\n", input_file, output_file))
}
