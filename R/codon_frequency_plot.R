#' Plot the codon frequency of a DNA sequence
#'
#' This function creates a bar plot representing the frequency of each codon in a given DNA sequence.
#'
#' @param dna_seq A character string representing a DNA sequence.
#'
#' @return A bar plot representing the frequency of each codon in the input DNA sequence.
#'
#' @examples
#' #codon_frequency_plot("ATGCGCTGCTAG")
#'
#' @export
codon_frequency_plot <- function(dna_seq) {
  # Define a vector of amino acid codes and their names
  aa_codes <- aa_library("ac")
  aa_names <- aa_library("an")
  aa_color_palette <- aa_library("acp")

  # Get the summary_df using the codon_frequency function
  summary_df <- codon_frequency(dna_seq)

  # Create a bar plot
  par(mar = c(8, 4, 4, 2))
  barplot(summary_df$Count, names.arg = summary_df$Codon,
          col = aa_color_palette[match(summary_df$Codon, aa_names)],
          main = "Codon Frequency", ylab = "Count",
          las = 2, cex.names = 0.8)
  mtext("Codon", side = 1, line = 6)

}

#' @rdname codon_frequency_plot
#' @export
cf_plot <- codon_frequency_plot
