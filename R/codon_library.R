#' Codon Library
#'
#' This function returns a vector of codon codes or codon names based on the input name.
#'
#' @param names A character vector indicating the name of the output. Can be one of "codon_codes", "amino_acid_triplets",
#' "aa_triplets", "cc" for codon codes, or "codon_names","aa_triplet_names","amino_acid_triplet_names", "aa_names", "cn" for codon names.
#' @return A vector of codon codes or codon names based on the input name.
#' @details The function contains a fixed vector of codon codes and codon names for each amino acid. The function returns
#' either a vector of codon codes or codon names based on the input name. If an invalid name is passed as input, an error
#' message is printed and the function stops.
#'
#' @examples
#' codon_library("codon_codes")
#' codon_library("codon_names")
#' codon_library("cc")
#' codon_library("cn")
#'
#' @export
codon_library <- function(names) {
  codon_codes <- c("TTT", "TTC", "TTA", "TTG", "CTT", "CTC", "CTA", "CTG", "ATT", "ATC",
                   "ATA", "ATG", "GTT", "GTC", "GTA", "GTG", "TCT", "TCC", "TCA", "TCG",
                   "CCT", "CCC", "CCA", "CCG", "ACT", "ACC", "ACA", "ACG", "GCT", "GCC",
                   "GCA", "GCG", "TAT", "TAC", "TAA", "TAG", "CAT", "CAC", "CAA", "CAG",
                   "AAT", "AAC", "AAA", "AAG", "GAT", "GAC", "GAA", "GAG", "TGT", "TGC",
                   "TGA", "TGG", "CGT", "CGC", "CGA", "CGG", "AGT", "AGC", "AGA", "AGG",
                   "GGT", "GGC", "GGA", "GGG")
  codon_names <- c("Phenylalanine", "Phenylalanine", "Leucine", "Leucine", "Leucine", "Leucine",
                   "Leucine", "Leucine", "Isoleucine", "Isoleucine", "Isoleucine", "Methionine",
                   "Valine", "Valine", "Valine", "Valine", "Serine", "Serine", "Serine", "Serine",
                   "Proline", "Proline", "Proline", "Proline", "Threonine", "Threonine", "Threonine",
                   "Threonine", "Alanine", "Alanine", "Alanine", "Alanine", "Tyrosine", "Tyrosine",
                   "Stop", "Stop", "Histidine", "Histidine", "Glutamine", "Glutamine", "Asparagine",
                   "Asparagine", "Lysine", "Lysine", "Aspartic acid", "Aspartic acid", "Glutamic acid",
                   "Glutamic acid", "Cysteine", "Cysteine", "Stop", "Tryptophan", "Arginine",
                   "Arginine", "Arginine", "Arginine", "Serine", "Serine", "Arginine", "Arginine",
                   "Glycine", "Glycine", "Glycine", "Glycine")

  if (names %in% c("codon_codes", "aa_triplets","amino_acid_triplets", "cc")) {
    return(codon_codes)
  } else if (names %in% c("codon_names", "aa_triplet_names", "amino_acid_triplet_names", "cn")) {
    return(codon_names)
  } else {
    stop(paste0("Invalid input name: '", names, "'. Use ?codon_library to get a list of acceptable commands."))
  }
}
