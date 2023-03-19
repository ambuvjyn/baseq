#' Reverse Transcription of a RNA sequence
#'
#' This function takes a DNA sequence as input and returns its RNA transcript.
#'
#' @param sequence A character string representing a DNA sequence.
#' @return A character string representing the RNA transcript of the input DNA sequence.
#' @examples
#' sequence <- "AUCGAGCUAGCUAGCUAGCUAGCU"
#' rna_to_dna(sequence)
#' # Returns "ATCGAGCTAGCTAGCTAGCTAGCT"
#' @export
rna_to_dna <- function(sequence) {
  # Convert the sequence to RNA by replacing T with U
  transcript <- gsub("U", "T", sequence)
  # Return the RNA transcript
  return(transcript)
}
