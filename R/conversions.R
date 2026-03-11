#' Universal Reverse Complement
#'
#' Generates the reverse complement of a DNA or RNA sequence.
#'
#' @param sequence A character string containing the sequence
#' @return A character string of the reverse complement
#' @export
rev_comp <- function(sequence) {
  if (is.null(sequence) || is.na(sequence) || nchar(sequence) == 0) return("")
  sequence <- toupper(sequence)
  if (grepl("U", sequence)) {
    comp <- c(A="U", U="A", G="C", C="G")
    chars <- strsplit(sequence, "")[[1]]
    res <- comp[chars]
    return(paste(rev(res), collapse=""))
  } else {
    comp <- c(A="T", T="A", G="C", C="G")
    chars <- strsplit(sequence, "")[[1]]
    res <- comp[chars]
    return(paste(rev(res), collapse=""))
  }
}

#' DNA to RNA
#'
#' Transcribes a DNA sequence into RNA.
#'
#' @param s A character string containing the DNA sequence
#' @return A character string of the RNA sequence
#' @export
dna_to_rna <- function(s) {
  if (is.null(s) || is.na(s)) return("")
  gsub("T", "U", toupper(s))
}

#' RNA to DNA
#'
#' Reverse transcribes an RNA sequence into DNA.
#'
#' @param s A character string containing the RNA sequence
#' @return A character string of the DNA sequence
#' @export
rna_to_dna <- function(s) {
  if (is.null(s) || is.na(s)) return("")
  gsub("U", "T", toupper(s))
}

#' Translate DNA to Protein
#'
#' Translates a DNA sequence into protein in all 6 reading frames.
#'
#' @param s A character string containing the DNA sequence
#' @param table Integer indicating the NCBI genetic code table (default: 1)
#' @return A list of translated protein sequences
#' @export
dna_to_protein <- function(s, table = 1) {
  if (is.null(s) || is.na(s) || nchar(s) < 3) return(list("Frame F1"=""))
  s <- toupper(s)
  gc <- get_genetic_code(table)
  trans <- function(seq) {
    if(nchar(seq) < 3) return("")
    codons <- substring(seq, seq(1, nchar(seq)-2, 3), seq(3, nchar(seq), 3))
    aa <- gc[codons]; st <- which(aa == "*")
    if (length(st) > 0) aa <- aa[1:(st[1]-1)]
    paste(aa, collapse="")
  }
  rc <- rev_comp(s)
  list("Frame F1"=trans(s), "Frame F2"=trans(substring(s,2)), "Frame F3"=trans(substring(s,3)),
       "Frame R1"=trans(rc), "Frame R2"=trans(substring(rc,2)), "Frame R3"=trans(substring(rc,3)))
}

#' Translate RNA to Protein
#'
#' Translates an RNA sequence into protein in all 6 reading frames.
#'
#' @param s A character string containing the RNA sequence
#' @param table Integer indicating the NCBI genetic code table (default: 1)
#' @return A list of translated protein sequences
#' @export
rna_to_protein <- function(s, table = 1) {
  if (is.null(s) || is.na(s)) return(list("Frame F1"=""))
  dna_to_protein(rna_to_dna(s), table)
}

#' Reverse Translation
#'
#' Converts a protein sequence back into DNA using common codons.
#'
#' @param s A character string containing the protein sequence
#' @return A character string of the resulting DNA sequence
#' @export
reverse_translate <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return("")
  bm <- c(F="TTT", L="TTA", I="ATT", M="ATG", V="GTT", S="TCT", P="CCT", T="ACT", A="GCT", Y="TAT", "*"="TAA", H="CAT", Q="CAA", N="AAT", K="AAA", D="GAT", E="GAA", C="TGT", W="TGG", R="CGT", G="GGT")
  res <- bm[strsplit(toupper(s), "")[[1]]]
  res[is.na(res)] <- "NNN"
  paste(res, collapse="")
}

#' Get Genetic Code
#'
#' Returns a mapping of codons to amino acids.
#'
#' @param table Integer NCBI genetic code table index
#' @return A named character vector
#' @export
get_genetic_code <- function(table = 1) {
  std <- c(
    TTT="F", TTC="F", TTA="L", TTG="L", CTT="L", CTC="L", CTA="L", CTG="L",
    ATT="I", ATC="I", ATA="I", ATG="M", GTT="V", GTC="V", GTA="V", GTG="V",
    TCT="S", TCC="S", TCA="S", TCG="S", CCT="P", CCC="P", CCA="P", CCG="P",
    ACT="T", ACC="T", ACA="T", ACG="T", GCT="A", GCC="A", GCA="A", GCG="A",
    TAT="Y", TAC="Y", TAA="*", TAG="*", CAT="H", CAC="H", CAA="Q", CAG="Q",
    AAT="N", AAC="N", AAA="K", AAG="K", GAT="D", GAC="D", GAA="E", GAG="E",
    TGT="C", TGC="C", TGA="*", TGG="W", CGT="R", CGC="R", CGA="R", CGG="R",
    AGT="S", AGC="S", AGA="R", AGG="R", GGT="G", GGC="G", GGA="G", GGG="G"
  )
  if (table == 2) { 
    std[c("AGA","AGG")] <- "*"
    std["ATA"] <- "M"
    std["TGA"] <- "W" 
  }
  return(std)
}
