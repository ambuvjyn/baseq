#' Clean DNA sequence
#'
#' This function takes a DNA sequence as input and removes any characters other than A, C, G, and T.
#'
#' @param sequence DNA sequence to be cleaned
#' @return Cleaned DNA sequence
#'
#' @examples
#' clean_DNA_sequence("ATGTCGTAGCTAGCTN")
#' # Output: "ATGTCGTAGCTAGCT"
#'
#' @export
clean_DNA_sequence <- function(sequence) {
  # Convert sequence to upper case
  sequence <- toupper(sequence)
  # Remove any characters that are not A, C, G, T
  sequence <- gsub("[^ACGT]", "", sequence)
  # Return the cleaned sequence
  return(sequence)
}
