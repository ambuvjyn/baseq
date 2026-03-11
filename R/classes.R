#' S3 DNA Class
#'
#' Creates an S3 object of class baseq_dna.
#'
#' @param s A character string containing the sequence
#' @return A baseq_dna object
#' @export
as_baseq_dna <- function(s) structure(clean_seq(s, "DNA"), class=c("baseq_dna", "character"))

#' S3 RNA Class
#'
#' Creates an S3 object of class baseq_rna.
#'
#' @param s A character string containing the sequence
#' @return A baseq_rna object
#' @export
as_baseq_rna <- function(s) structure(clean_seq(s, "RNA"), class=c("baseq_rna", "character"))

#' @export
print.baseq_dna <- function(x, ...) {
  cat("DNA Sequence (", nchar(x), " bases)\n", substr(x, 1, 50), if(nchar(x)>50) "..." else "", "\n", sep="")
}

#' @export
print.baseq_rna <- function(x, ...) {
  cat("RNA Sequence (", nchar(x), " bases)\n", substr(x, 1, 50), if(nchar(x)>50) "..." else "", "\n", sep="")
}

#' Generic Translate
#'
#' Generic function to translate DNA or RNA to protein.
#'
#' @param x A baseq_dna or baseq_rna object
#' @param ... Additional arguments
#' @return A list of translated sequences
#' @export
translate <- function(x, ...) UseMethod("translate")

#' @export
translate.baseq_dna <- function(x, ...) dna_to_protein(as.character(x))

#' @export
translate.baseq_rna <- function(x, ...) rna_to_protein(as.character(x))

#' @export
translate.default <- function(x, ...) stop("Convert to baseq_dna/rna first.")

#' Bioconductor Bridge
#'
#' Converts baseq sequences to Biostrings format.
#'
#' @param s A character vector or list of sequences
#' @return A DNAStringSet object
#' @export
as_Biostrings <- function(s) {
  if(!requireNamespace("Biostrings", quietly=T)) stop("Biostrings required.")
  Biostrings::DNAStringSet(unlist(s))
}
