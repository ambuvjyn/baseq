#' Reverse Transcription of a RNA sequence
#'
#' This function takes a RNA sequence as input and returns its DNA transcript.
#'
#' @param sequence A character string representing a RNA sequence.
#' @return A character string representing the RNA transcript of the input RNA sequence.
#' @examples
#' sequence <- "AUCGAGCUAGCUAGCUAGCUAGCU"
#' rna_to_dna(sequence)
#' # Returns "ATCGAGCTAGCTAGCTAGCTAGCT"
#' @export
rna_to_dna <- function(sequence) {
  # Convert the sequence to DNA by replacing U with T
  transcript <- gsub("U", "T", sequence)
  # Return the DNA transcript
  return(transcript)
}
