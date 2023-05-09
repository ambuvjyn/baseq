#' Calculate the frequency of amino acids in a protein sequence
#'
#' This function takes a protein sequence as input and returns a data frame
#' summarizing the frequency of each amino acid in the sequence.
#'
#' @param protein_seq A character string representing the protein sequence
#' @return A data frame with two columns: Amino_Acid and Count, where Amino_Acid
#' is the name of the amino acid and Count is the number of times it occurs
#' in the protein sequence.
#'
#' @examples
#' amino_acid_frequency("MSRSLLLRFLLFLLLLPPLP")
#'
#' @export
amino_acid_frequency <- function(protein_seq) {

  # Convert protein sequence to uppercase
  protein_seq <- toupper(protein_seq)

  # Define a vector of amino acid codes and their names
  aa_codes <- c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M",
                "N", "P", "Q", "R", "S", "T", "V", "W", "Y")
  aa_names <- c("Alanine", "Cysteine", "Aspartic acid", "Glutamic acid", "Phenylalanine",
                "Glycine", "Histidine", "Isoleucine", "Lysine", "Leucine", "Methionine",
                "Asparagine", "Proline", "Glutamine", "Arginine", "Serine", "Threonine",
                "Valine", "Tryptophan", "Tyrosine")

  # Initialize count for each amino acid to zero
  aa_count <- rep(0, length(aa_codes))

  # Loop through the protein sequence and count the occurrence of each amino acid
  for (i in 1:nchar(protein_seq)) {
    aa <- substr(protein_seq, i, i)
    if (aa %in% aa_codes) {
      aa_count[which(aa_codes == aa)] <- aa_count[which(aa_codes == aa)] + 1
    }
  }

  # Create a data frame with amino acid names and counts
  summary_df <- data.frame(Amino_Acid = aa_names, Count = aa_count, stringsAsFactors = FALSE)

  return(summary_df)
}

#' @rdname amino_acid_frequency
#' @export
aa_freq <- amino_acid_frequency
