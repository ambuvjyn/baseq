#' Clean RNA sequence
#'
#' This function takes a RNA sequence as input and removes any characters other than A, C, G, and T.
#'
#' @param sequence RNA sequence to be cleaned
#' @return Cleaned RNA sequence
#'
#' @examples
#' clean_RNA_sequence("AUGUCGTAGCTAGCTN")
#' # Output: "AUGUCGAGCAGC"
#'
#' @export
clean_RNA_sequence <- function(sequence) {
  # Convert sequence to upper case
  sequence <- toupper(sequence)
  # Remove any characters that are not A, C, G, U
  sequence <- gsub("[^ACGU]", "", sequence)
  # Return the cleaned sequence
  return(sequence)
}
