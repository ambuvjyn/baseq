#' Transcription of a DNA sequence
#'
#' This function takes a DNA sequence as input and returns its RNA transcript.
#'
#' @param sequence A character string representing a DNA sequence.
#' @return A character string representing the RNA transcript of the input DNA sequence.
#' @examples
#' sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
#' dna_to_rna(sequence)
#' # Returns "AUCGAGCUAGCUAGCUAGCUAGCU"
#' @export
dna_to_rna <- function(sequence) {
  # Convert the sequence to RNA by replacing T with U
  transcript <- gsub("T", "U", sequence)
  # Return the RNA transcript
  return(transcript)
}
