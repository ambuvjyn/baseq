#' Calculate Extinction Coefficient for Proteins in a Data Frame
#'
#' This function calculates the extinction coefficient for each protein sequence in a data frame and appends the result as a new column in the same data frame.
#'
#' @param protein_df A data frame containing a column named "Sequence" with the protein sequences to calculate extinction coefficients for.
#'
#' @return A data frame with a new column named "Extinction_Coefficient" containing the extinction coefficients for each protein sequence.
#'
#' @examples
#' protein <- generate_multi_protein_sequences_as_df(10,50)
#' bulk_calculate_extinction_coefficient(protein)
#'
#' @export
bulk_calculate_extinction_coefficient <- function(protein_df) {
  extinction_coeffs <- sapply(protein_df$Sequence, calculate_extinction_coefficient)
  protein_df$Extinction_Coefficient <- extinction_coeffs
  return(protein_df)
}
