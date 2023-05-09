#' Generate Random DNA Sequence
#'
#' Generates a random DNA sequence of a given length.
#'
#' @param length The length of the DNA sequence to generate.
#'
#' @return A character string representing a random DNA sequence.
#'
#' @examples
#' generate_random_dna_sequence(10)
#'
#' @export
generate_random_dna_sequence <- function(length) {
  bases <- c("A", "C", "G", "T")
  dna_seq <- paste(sample(bases, length, replace=TRUE), collapse="")
  return(dna_seq)
}
