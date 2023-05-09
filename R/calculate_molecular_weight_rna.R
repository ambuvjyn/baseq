#' Calculate the molecular weight of an RNA sequence
#'
#' This function calculates the molecular weight of an RNA sequence using the following formula:
#'
#' \code{Molecular weight = sum of (number of nucleotides of each type * molecular weight of each nucleotide)}
#'
#' @param rna_seq A character string representing the RNA sequence
#'
#' @return A numeric value representing the molecular weight of the RNA sequence in g/mol
#'
#' @examples
#' calculate_molecular_weight_rna("AGCUUAGCUA")
#'
#' @export
calculate_molecular_weight_rna <- function(rna_seq) {
  # Define a table of molecular weights of nucleotides in g/mol
  nucleotide_weights <- data.frame(base=c("A", "U", "C", "G"), weight=c(313.2, 306.2, 289.2, 329.2))

  # Convert the rna sequence to uppercase
  rna_seq <- toupper(rna_seq)

  # Calculate the molecular weight of the rna sequence
  weight <- sum(nucleotide_weights$weight[match(strsplit(rna_seq, "")[[1]], nucleotide_weights$base)])

  return(weight)
}

#' @rdname calculate_molecular_weight_rna
#' @export
mw_rna <- calculate_molecular_weight_rna
