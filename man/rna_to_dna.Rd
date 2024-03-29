% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rna_to_dna.R
\name{rna_to_dna}
\alias{rna_to_dna}
\title{Reverse Transcription of a RNA sequence}
\usage{
rna_to_dna(sequence)
}
\arguments{
\item{sequence}{A character string representing a RNA sequence.}
}
\value{
A character string representing the RNA transcript of the input RNA sequence.
}
\description{
This function takes a RNA sequence as input and returns its DNA transcript.
}
\examples{
sequence <- "AUCGAGCUAGCUAGCUAGCUAGCU"
rna_to_dna(sequence)
# Returns "ATCGAGCTAGCTAGCTAGCTAGCT"
}
