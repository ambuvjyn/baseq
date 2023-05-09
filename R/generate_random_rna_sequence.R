#' Generate a random RNA sequence
#'
#' This function generates a random RNA sequence of a given length.
#'
#' @param length the length of the RNA sequence to be generated
#' @return a character string representing the generated RNA sequence
#'
#' @examples
#' generate_random_rna_sequence(10)
#'
#' @export
generate_random_rna_sequence <- function(length) {
  bases <- c("A", "C", "G", "U")
  dna_seq <- paste(sample(bases, length, replace=TRUE), collapse="")
  return(dna_seq)
}
