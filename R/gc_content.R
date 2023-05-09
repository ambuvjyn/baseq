#' Calculate GC content of a DNA sequence
#'
#' Calculates the percentage of nucleotides in a DNA sequence that are either guanine (G) or cytosine (C).
#'
#' @param sequence A character string containing the DNA sequence.
#' @return A numeric value representing the percentage of nucleotides in the sequence that are G or C.
#' @examples
#' sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
#' gc_content(sequence)
#' 50
#' @export
gc_content <- function(sequence) {
  # Check input validity
  if (!is.character(sequence)) {
    stop("Input sequence must be a character string.")
  }
  if (length(sequence) != 1) {
    stop("Input sequence must be a single string.")
  }
  if (grepl("[^ACGTU]", sequence)) {
    stop("Input sequence contains invalid characters.")
  }
  
  # Calculate GC content
  gc_count <- sum(sapply(strsplit(sequence, ""), function(x) x %in% c("G", "C")))
  gc_content <- gc_count / nchar(sequence) * 100
  
  # Return result
  return(gc_content)
}
