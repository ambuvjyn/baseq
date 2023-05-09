#' Calculate Molecular Weight of a Protein Sequence
#'
#' This function calculates the molecular weight of a given protein sequence based on the molecular weights of its constituent amino acids.
#'
#' @param protein_seq A character string representing the protein sequence. It should consist only of the standard amino acid symbols (A, C, D, E, F, G, H, I, K, L, M, N, P, Q, R, S, T, V, W, Y) in uppercase.
#'
#' @return A numeric value representing the molecular weight of the protein sequence in g/mol.
#'
#' @examples
#' calculate_molecular_weight_protein("MKGHHLMLLGLLGLVLALGGSSSAQAKL")
#'
#' @export
calculate_molecular_weight_protein <- function(protein_seq) {
  # Define a table of molecular weights of nucleotides in g/mol
  nucleotide_weights <- data.frame(base=c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"), weight=c(89.1, 121.2, 133.1, 147.1, 165.2, 75.1, 155.2, 131.2, 146.2, 131.2, 149.2, 132.1, 115.1, 146.2, 174.2, 105.1, 119.1, 117.1, 204.2, 181.2))

  # Convert the protein sequence to uppercase
  protein_seq <- toupper(protein_seq)

  # Calculate the molecular weight of the protein sequence
  weight <- sum(nucleotide_weights$weight[match(strsplit(protein_seq, "")[[1]], nucleotide_weights$base)])

  return(weight)
}

#' @rdname calculate_molecular_weight_protein
#' @export
mw_protein <- calculate_molecular_weight_protein
