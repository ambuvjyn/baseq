#' Calculate the frequency of each codon in a DNA sequence
#'
#' This function takes a DNA sequence and calculates the frequency of each
#' codon in the sequence. The function returns a data frame with the name of
#' each codon and its frequency in the sequence.
#'
#' @param dna_seq A character string representing a DNA sequence.
#'
#' @return A data frame with two columns: Codon (the name of each codon) and Count
#' (the frequency of each codon in the input DNA sequence).
#'
#' @examples
#' codon_frequency("ATGCGCTGCTAG")
#'
#' @export
codon_frequency <- function(dna_seq) {

  # Convert DNA sequence to uppercase
  dna_seq <- toupper(dna_seq)

  # Define a vector of codons and their names
  codon_codes <- codon_library("cc")
  codon_names <- codon_library("cn")

  # Initialize count for each codon to zero
  codon_count <- rep(0, length(codon_codes))

  # Loop through the three forward and reverse frames and count the occurrence of each codon
  for (frame in c(1, 2, 3, -1, -2, -3)) {
    if (frame > 0) {
      dna_frame <- substr(dna_seq, frame, nchar(dna_seq))
    } else {
      dna_frame <- reverse_complement(substr(dna_seq, 1, nchar(dna_seq) - frame + 1))
    }

    for (i in seq(1, nchar(dna_frame), 3)) {
      codon <- substr(dna_frame, i, i+2)
      if (codon %in% codon_codes) {
        codon_count[which(codon_codes == codon)] <- codon_count[which(codon_codes == codon)] + 1
      }
    }
  }

  #Aggregate the counts by codon name
  codon_count <- tapply(codon_count, codon_names, sum)

  #Create a data frame with codon names and counts
  summary_df <- data.frame(Codon = names(codon_count), Count = as.numeric(unlist(codon_count)), stringsAsFactors = FALSE)
  summary_df <- subset(summary_df, Count != 0)

  return(summary_df)
}

#' @rdname codon_frequency
#' @export
codon_freq <- codon_frequency
