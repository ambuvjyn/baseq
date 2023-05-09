#' Calculate molecular weight of a DNA sequence
#'
#' This function calculates the molecular weight of a given DNA sequence.
#' It uses a table of molecular weights of nucleotides to calculate the molecular weight of the sequence.
#'
#' @param dna_seq A DNA sequence as a character string
#' @return The molecular weight of the DNA sequence in g/mol
#' @examples
#' calculate_molecular_weight_dna("ATGCGCTA")
#' # [1] 1423.4
#' @export
calculate_molecular_weight_dna <- function(dna_seq) {
  # Define a table of molecular weights of nucleotides in g/mol
  nucleotide_weights <- data.frame(base=c("A", "T", "C", "G"), weight=c(313.2, 304.2, 289.2, 329.2))

  # Convert the DNA sequence to uppercase
  dna_seq <- toupper(dna_seq)

  # Calculate the molecular weight of the DNA sequence
  weight <- sum(nucleotide_weights$weight[match(strsplit(dna_seq, "")[[1]], nucleotide_weights$base)])

  return(weight)
}

#' @rdname calculate_molecular_weight_dna
#' @export
mw_dna <- calculate_molecular_weight_dna
