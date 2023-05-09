#' Generate a random protein sequence
#'
#' This function generates a random protein sequence of a given length using the frequencies of each of the 20 amino acids in the human proteome.
#'
#' @param length The length of the protein sequence to be generated.
#' @return A character string representing the generated protein sequence.
#'
#' @examples
#' generate_random_protein_sequence(10)
#'
#' @export
generate_random_protein_sequence <- function(length) {

  # Define the 20 amino acids and their frequencies
  amino_acids <- c("A","C","D","E","F","G","H","I","K","L","M","N",
                   "P","Q","R","S","T","V","W","Y")
  freqs <- c(0.074,0.033,0.059,0.058,0.040,0.074,0.029,0.038,0.072,
             0.076,0.018,0.039,0.050,0.037,0.042,0.063,0.089,0.052,
             0.010,0.029)

  # Generate a random sequence of amino acids
  seq <- sample(amino_acids, size=length, replace=TRUE, prob=freqs)

  # Combine the sequence into a single string
  return(paste(seq, collapse=""))
}
