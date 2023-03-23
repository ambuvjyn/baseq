#' Clean DNA/RNA sequence
#'
#' This function cleans DNA/RNA sequences by removing any characters that are not A, C, G, T/U.
#'
#' @param sequence a DNA/RNA sequence string
#' @param type a character string indicating the type of sequence ("DNA" or "RNA")
#' @return a cleaned DNA/RNA sequence string
#'
#' @examples
#' sequence <- "ATGACTGCNATGCNCTAG"
#' clean_sequence(sequence, type = "DNA")
#' # [1] "ATGACTGCATGCCTAG"
#'
#' sequence <- "AUGACUGCNAUGCNCUAG"
#' clean_sequence(sequence, type = "RNA")
#' # [1] "AUGACUGCAUGCCUAG"
#' @export
#' @importFrom stringr str_replace_all
#' @importFrom stringr str_to_upper
clean_sequence <- function(sequence, type = "DNA") {
  # Convert sequence to upper case
  sequence <- stringr::str_to_upper(sequence)
  if (type == "DNA") {
    # Remove any characters that are not A, C, G, T
    sequence <- stringr::str_replace_all(sequence, "[^ACGT]", "")
  } else if (type == "RNA") {
    # Remove any characters that are not A, C, G, U
    sequence <- stringr::str_replace_all(sequence, "[^ACGU]", "")
  } else {
    # Stop execution if type is not "DNA" or "RNA"
    stop("Invalid sequence type. Please specify 'DNA' or 'RNA'.")
  }
  # Return the cleaned sequence
  return(sequence)
}
