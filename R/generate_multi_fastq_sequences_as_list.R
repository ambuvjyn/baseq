#' Generate Multiple FASTQ Sequences as List
#'
#' This function generates a list of multiple FASTQ sequences. Each sequence in the list contains two elements: the DNA sequence and the quality score.
#'
#' @param num_seq An integer indicating the number of sequences to be generated.
#' @param seq_length An integer indicating the length of each sequence to be generated.
#'
#' @return A list of multiple FASTQ sequences. Each sequence contains two elements: "Sequence" and "QualityScore".
#'
#' @examples
#' generate_multi_fastq_sequences_as_list(5, 20)
#'
#' @export
generate_multi_fastq_sequences_as_list <- function(num_seq, seq_length) {
  seqs <- lapply(paste0("seq_", 1:num_seq), function(seq_name) {
    dna_seq <- paste0(sample(c("A", "C", "T", "G"), seq_length, replace=TRUE), collapse="")
    quality_score <- paste0(sample(c(0:9, "A", "B", "C", "D", "E", "F"), seq_length, replace=TRUE), collapse="")
    list(Sequence = dna_seq, QualityScore = quality_score)
  })
  names(seqs) <- paste0("seq_", 1:num_seq)
  return(seqs)
}
