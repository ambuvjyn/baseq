#' Generate multiple FASTQ sequences
#'
#' This function generates a specified number of FASTQ sequences with random nucleotides and quality scores.
#'
#' @param num_seq Number of sequences to generate.
#' @param seq_length Length of each sequence.
#'
#' @return A character vector of generated FASTQ sequences.
#'
#' @examples
#' generate_multi_fastq_sequences(5, 50)
#'
#' @export
generate_multi_fastq_sequences <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    fastq_seq <- paste0(sample(c("A", "C", "G", "T"), seq_length, replace=TRUE), collapse="")
    fastq_qual <- paste0(sample(c("!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",",
                                  "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                                  ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F",
                                  "G", "H", "I"), seq_length, replace=TRUE), collapse="")
    paste0("@", seq_name, "\n", fastq_seq, "\n", "+", "\n", fastq_qual)
  })
  cat(seqs, sep="\n")
}
