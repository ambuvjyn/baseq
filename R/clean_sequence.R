#' Clean DNA or RNA sequence
#'
#' This function takes a DNA or RNA sequence as input and removes any characters that are not A, C, G, T (for DNA) or A, C, G, U (for RNA).
#'
#' @param sequence A character string containing the DNA or RNA sequence to be cleaned.
#' @param type A character string indicating the type of sequence. The default is "DNA". If set to "RNA", the function will remove any characters that are not A, C, G, U.
#' @return A character string containing the cleaned DNA or RNA sequence.
#' @examples
#' clean_sequence("atgcNnRYMK") # Returns "ATGC"
#' clean_sequence("auggcuuNnRYMK", type = "RNA") # Returns "AUGGCUU"
#' @export
clean_sequence <- function(sequence, type = "DNA") {
  # Convert sequence to upper case
  sequence <- toupper(sequence)
  if (type == "DNA") {
    # Remove any characters that are not A, C, G, T
    sequence <- gsub("[^ACGT]", "", sequence)
  } else if (type == "RNA") {
    # Remove any characters that are not A, C, G, U
    sequence <- gsub("[^ACGU]", "", sequence)
  } else {
    # Stop execution if type is not "DNA" or "RNA"
    stop("Invalid sequence type. Please specify 'DNA' or 'RNA'.")
  }
  # Return the cleaned sequence
  return(sequence)
}
