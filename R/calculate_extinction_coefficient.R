#' Calculate extinction coefficient
#'
#' This function calculates the extinction coefficient of a protein sequence at 280 nm based on the molar extinction coefficients of its constituent amino acids.
#'
#' @param protein_sequence A character vector representing the protein sequence.
#' @return The extinction coefficient of the protein sequence at 280 nm.
#'
#' @examples
#' calculate_extinction_coefficient("MKTIIALSYIFCLGLAGSTNVTEAITCQQLYQFVSGNLEKI")
#'
#' @export
calculate_extinction_coefficient <- function(protein_sequence) {
  # Define the molar extinction coefficients for the 20 amino acids at 280 nm
  aa_ext_coef <- c(W = 5500, Y = 1490, F = 2650, M = 135, L = 190, I = 210, V = 165,
                   H = 1290, K = 120, R = 280, E = 120, D = 390, N = 120, Q = 190,
                   C = 125, S = 60, T = 90, P = 75, A = 35, G = 0)

  # Convert the sequence to upper case
  protein_sequence <- toupper(protein_sequence)

  # Convert the protein sequence to uppercase and count the number of each amino acid
  aa_counts <- table(factor(strsplit(protein_sequence, "")[[1]], levels = c("A", "R", "N", "D", "C", "Q", "E", "G", "H", "I", "L", "K", "M", "F", "P", "S", "T", "W", "Y", "V")))

  # Calculate the extinction coefficient using the formula: E = sum(ni * ei)
  extinction_coef <- sum(c(aa_counts) * c(aa_ext_coef))

  # Return the extinction coefficient
  return(extinction_coef)
}

