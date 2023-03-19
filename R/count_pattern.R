#' Count frequency of a pattern in a sequence
#'
#' This function counts the frequency of a specific character or pattern in a given sequence.
#'
#' @param seq A character vector representing the sequence to count the pattern in.
#' @param pattern A character string representing the pattern to count in the sequence.
#'
#' @return An integer representing the count of the pattern in the sequence.
#'
#' @examples
#' seq <- "ATGGTGCTCCGTGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCGCTACGTAG"
#' count(seq, "CG")
#' # output: 14
#'
#' @export
count <- function(seq, pattern) {
  # convert sequence to uppercase for case-insensitivity
  seq <- toupper(seq)

  # count frequency of pattern in sequence
  pattern_count <- length(gregexpr(pattern, seq)[[1]])

  return(pattern_count)
}
