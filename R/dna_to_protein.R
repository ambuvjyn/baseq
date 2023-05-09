#' Translation of a DNA sequence
#'
#' This function takes a DNA sequence as input and translates it in all six reading frames.
#'
#' @param sequence A character string representing a DNA sequence.
#' @return A list of character strings representing the translated protein sequences in all six frames.
#' @examples
#' sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
#' dna_to_protein(sequence)
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
dna_to_protein <- function(sequence) {

  # Create a list to store the protein sequences
  proteins <- list()

  # Define the genetic code as a named vector
  genetic_code <- c(
    "TTT"="F", "TTC"="F", "TTA"="L", "TTG"="L", "CTT"="L", "CTC"="L", "CTA"="L", "CTG"="L",
    "ATT"="I", "ATC"="I", "ATA"="I", "ATG"="M", "GTT"="V", "GTC"="V", "GTA"="V", "GTG"="V",
    "TCT"="S", "TCC"="S", "TCA"="S", "TCG"="S", "CCT"="P", "CCC"="P", "CCA"="P", "CCG"="P",
    "ACT"="T", "ACC"="T", "ACA"="T", "ACG"="T", "GCT"="A", "GCC"="A", "GCA"="A", "GCG"="A",
    "TAT"="Y", "TAC"="Y", "TAA"="*", "TAG"="*", "CAT"="H", "CAC"="H", "CAA"="Q", "CAG"="Q",
    "AAT"="N", "AAC"="N", "AAA"="K", "AAG"="K", "GAT"="D", "GAC"="D", "GAA"="E", "GAG"="E",
    "TGT"="C", "TGC"="C", "TGA"="*", "TGG"="W", "CGT"="R", "CGC"="R", "CGA"="R", "CGG"="R",
    "AGT"="S", "AGC"="S", "AGA"="R", "AGG"="R", "GGT"="G", "GGC"="G", "GGA"="G", "GGG"="G"
  )

  # Loop through each frame (1 forward, 2 forward, 3 forward, 1 reverse, 2 reverse, 3 reverse) and translate the sequence
  for (f in c(1,2,3,-1,-2,-3)) {

    # Get the sequence in the current frame
    if (f > 0) {
      current_seq <- substring(sequence, f)
      frame_name <- paste0("Frame F", f)
    } else {
      current_seq <- reverse_complement(substring(sequence, abs(f)))
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
