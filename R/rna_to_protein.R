#' Translation of a RNA sequence
#'
#' This function takes a RNA sequence as input and translates it in all six reading frames.
#'
#' @param sequence A character string representing a RNA sequence.
#' @return A list of character strings representing the translated protein sequences in all six frames.
#' @examples
#' sequence <- "AUCGAGCUAGCUAGCUAGCUAGCU"
#' rna_to_protein(sequence)
#' # Returns a list containing the translated protein sequences in all six frames:
#' # $`Frame F1`
#' # [1] "IELAS"
#' #
#' # $`Frame F2`
#' # [1] "SS"
#' #
#' # $`Frame F3`
#' # [1] "RAS"
#' #
#' # $`Frame R1`
#' # [1] "S"
#' #
#' # $`Frame R2`
#' # [1] "AS"
#' #
#' # $`Frame R3`
#' # [1] "LAS"
#' @export
rna_to_protein <- function(sequence) {

  # Create a list to store the protein sequences
  proteins <- list()

  # Define the genetic code as a named vector
  genetic_code <- c(
    "UUU"="F", "UUC"="F", "UUA"="L", "UUG"="L", "CUU"="L", "CUC"="L", "CUA"="L", "CUG"="L",
    "AUU"="I", "AUC"="I", "AUA"="I", "AUG"="M", "GUU"="V", "GUC"="V", "GUA"="V", "GUG"="V",
    "UCU"="S", "UCC"="S", "UCA"="S", "UCG"="S", "CCU"="P", "CCC"="P", "CCA"="P", "CCG"="P",
    "ACU"="T", "ACC"="T", "ACA"="T", "ACG"="T", "GCU"="A", "GCC"="A", "GCA"="A", "GCG"="A",
    "UAU"="Y", "UAC"="Y", "UAA"="*", "UAG"="*", "CAU"="H", "CAC"="H", "CAA"="Q", "CAG"="Q",
    "AAU"="N", "AAC"="N", "AAA"="K", "AAG"="K", "GAU"="D", "GAC"="D", "GAA"="E", "GAG"="E",
    "UGU"="C", "UGC"="C", "UGA"="*", "UGG"="W", "CGU"="R", "CGC"="R", "CGA"="R", "CGG"="R",
    "AGU"="S", "AGC"="S", "AGA"="R", "AGG"="R", "GGU"="G", "GGC"="G", "GGA"="G", "GGG"="G"
  )

  # Loop through each frame (1 forward, 2 forward, 3 forward, 1 reverse, 2 reverse, 3 reverse) and translate the sequence
  for (f in c(1,2,3,-1,-2,-3)) {

    # Get the sequence in the current frame
    if (f > 0) {
      current_seq <- substring(sequence, f)
      frame_name <- paste0("Frame F", f)
    } else {
      current_seq <- rna_reverse_complement(substring(sequence, abs(f)))
      if (f == -2) current_seq <- substring(current_seq, 2)
      if (f == -3) current_seq <- substring(current_seq, 3)
      frame_name <- paste0("Frame R", abs(f))
    }

    # Translate the sequence in triplets
    protein_sequence <- ""
    for (i in seq(1, nchar(current_seq), by=3)) {
      codon <- substr(current_seq, i, i+2)
      if (nchar(codon) == 3) {
        aa <- genetic_code[codon]
        if (aa == "*") break
        protein_sequence <- paste0(protein_sequence, aa)
      }
    }

    # Save the protein sequence
    proteins[[frame_name]] <- protein_sequence

  }

  # Return the list of protein sequences
  return(proteins)

}
