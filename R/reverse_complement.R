#' Generate Reverse Complement of DNA sequence
#'
#' Given a DNA sequence, the function generates the reverse complement of the sequence and returns it.
#'
#' @param sequence A character string containing the DNA sequence to be reversed and complemented
#' @return A character string containing the reverse complement of the input DNA sequence
#' @examples
#' sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
#' reverse_complement(sequence)
#' # [1] "AGCTAGCTAGCTAGCTAGCTCGAT"
#' @export
reverse_complement <- function(sequence) {

  # Convert the sequence to upper case to make it case-insensitive
  sequence <- toupper(sequence)

  # Create a named vector of base complements
  complements <- c(A="T", C="G", G="C", T="A")

  # Reverse the sequence and replace each base with its complement
  complement_sequence <- sapply(strsplit(sequence, "")[[1]], function(base) complements[[base]])
  reverse_complement_sequence <- paste(rev(complement_sequence), collapse="")

  # Return the reverse complement sequence
  return(reverse_complement_sequence)
}
