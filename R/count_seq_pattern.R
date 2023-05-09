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
#' count_seq_pattern(seq, "CG")
#' # [1] 31
#'
#' @export
count_seq_pattern <- function(seq, pattern) {
  # convert sequence to uppercase for case-insensitivity
  seq <- toupper(seq)

  # count frequency of pattern in sequence
  pat_count <- length(gregexpr(pattern, seq)[[1]])

  return(pat_count)
}
