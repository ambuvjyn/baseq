#' Clean a protein sequence by removing non-standard amino acid codes
#'
#' This function takes a protein sequence as input and removes any characters
#' that are not standard amino acid codes. It then returns the cleaned sequence.
#'
#' @param sequence A character string representing a protein sequence.
#'
#' @return A character string representing the cleaned protein sequence.
#'
#' @examples
#' clean_protein_sequence("MAEGEITTFTALTEK$^3556FNLPPGNYKKPKLLCSNGGHDGTVDGTRDR")
#'
#' @export
clean_protein_sequence <- function(sequence) {
  # Convert sequence to upper case
  sequence <- toupper(sequence)
  # Remove any characters that are not standard amino acid codes
  sequence <- gsub("[^ACDEFGHIKLMNPQRSTVWY]", "", sequence)
  # Return the cleaned sequence
  return(sequence)
}

#' @rdname clean_protein_sequence
#' @export
clean_prot <- clean_protein_sequence
