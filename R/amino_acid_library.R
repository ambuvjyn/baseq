#' Get a vector of amino acid codes, names, or color palette
#'
#' @param names character vector. Names of the requested amino acid library components.
#' Possible values are "aa_codes", "amino_acid_codes", "ac", "aa_names", "amino_acid_names", "an",
#' "aa_colors", "amino_acid_colors", "acp".
#'
#' @return A character vector containing amino acid codes, names, or color palette.
#'
#' @details This function returns a vector of amino acid codes, names, or a color palette
#' for visualizing amino acids. The color palette consists of 21 colors, each corresponding
#' to an amino acid or stop codon. The function can be used with three different argument values:
#'
#' - "aa_codes", "amino_acid_codes", "ac": returns a character vector of amino acid codes.
#' - "aa_names", "amino_acid_names", "an": returns a character vector of amino acid names.
#' - "aa_colors", "amino_acid_colors", "acp": returns a character vector of color codes
#' corresponding to amino acids and stop codons.
#'
#' @examples
#' amino_acid_library("aa_names")
#' amino_acid_library("amino_acid_codes")
#' amino_acid_library("amino_acid_colors")
#'
#' @export
amino_acid_library <- function(names) {
  # Define a vector of amino acid codes and their names
  aa_codes <- c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M",
              "N", "P", "Q", "R", "S", "T", "V", "W", "Y", "*")
  aa_names <- c("Alanine", "Cysteine", "Aspartic acid", "Glutamic acid", "Phenylalanine",
              "Glycine", "Histidine", "Isoleucine", "Lysine", "Leucine", "Methionine",
              "Asparagine", "Proline", "Glutamine", "Arginine", "Serine", "Threonine",
              "Valine", "Tryptophan", "Tyrosine", "Stop")
  # Set color palette
  aa_color_palette <- c("#4e79a7", "#59a14f", "#9c755f", "#f28e2b", "#edc948", "#bab0ac",
                      "#e15759", "#76b7b2", "#b07aa1", "#ff9da7", "#9c9ede", "#d37295",
                      "#97bc64", "#a55194", "#434343", "#8c8c8c", "#ffa600", "#003f5c",
                      "#58508d", "#bc5090", "#FF0000")

  if (names %in% c("aa_codes", "amino_acid_codes", "ac")) {
    return(aa_codes)
  } else if (names %in% c("aa_names", "amino_acid_names", "an")) {
    return(aa_names)
  } else if (names %in% c("aa_colors", "amino_acid_colors", "acp")) {
    return(aa_color_palette)
  } else {
    stop(paste0("Invalid input name: '", names, "'. Use ?aa_library to get a list of acceptable commands."))
  }
}

#' @rdname amino_acid_library
#' @export
aa_library <- amino_acid_library
