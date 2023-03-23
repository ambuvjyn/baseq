#' Count the number of A's, C's, G's, and T's in a DNA sequence
#'
#' This function takes a single argument, a DNA sequence as a character string,
#' and counts the number of A's, C's, G's, and T's in the sequence. The counts
#' are returned as a named vector.
#'
#' @param sequence a character string containing a DNA sequence
#' @return a named integer vector containing the counts of A's, C's, G's, and T's
#' @examples
#' sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
#' count_bases(sequence)
#' # A  C  G  T
#' # 6  6  6  6
#' @export
count_bases <- function(sequence) {
  # Convert the sequence to upper case to make it case-insensitive
  sequence <- toupper(sequence)

  # Count the number of each base
  a_count <- nchar(gsub("[^A]", "", sequence))
  c_count <- nchar(gsub("[^C]", "", sequence))
  g_count <- nchar(gsub("[^G]", "", sequence))
  t_count <- nchar(gsub("[^T]", "", sequence))

  # Create a named vector of the counts
  counts <- c(A=a_count, C=c_count, G=g_count, T=t_count)

  # Return the counts
  return(counts)
}
