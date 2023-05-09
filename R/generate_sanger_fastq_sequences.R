
#' Generate Sanger FASTQ Sequences
#'
#' This function generates a specified number of Sanger FASTQ sequences with a given length.
#'
#' @param num_seq The number of sequences to generate.
#' @param seq_length The length of the sequences to generate.
#'
#' @return A character vector of the generated Sanger FASTQ sequences.
#'
#' @examples
#' generate_sanger_fastq_sequences(2, 10)
#'
#' @export
generate_sanger_fastq_sequences <- function(num_seq, seq_length) {
  seqs <- sapply(paste0("seq_", 1:num_seq), function(seq_name) {
    fastq_seq <- paste0(sample(c("A", "C", "G", "T"), seq_length, replace=TRUE), collapse="")
    fastq_qual <- paste0(sample(c("!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+", ",",
                                  "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
                                  ":", ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F",
                                  "G", "H", "I", "J", "K", "L", "M", "N", "O", "P"), seq_length, replace=TRUE), collapse="")
    paste0("@", seq_name, "\n", fastq_seq, "\n", "+", "\n", fastq_qual)
  })
  cat(seqs, sep="\n")
}
