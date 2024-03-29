% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dna_to_protein.R
\name{dna_to_protein}
\alias{dna_to_protein}
\title{Translation of a DNA sequence}
\usage{
dna_to_protein(sequence)
}
\arguments{
\item{sequence}{A character string representing a DNA sequence.}
}
\value{
A list of character strings representing the translated protein sequences in all six frames.
}
\description{
This function takes a DNA sequence as input and translates it in all six reading frames.
}
\examples{
sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
dna_to_protein(sequence)
# Returns a list containing the translated protein sequences in all six frames:
# $`Frame F1`
# [1] "IELAS"
#
# $`Frame F2`
# [1] "SS"
#
# $`Frame F3`
# [1] "RAS"
#
# $`Frame R1`
# [1] "S"
#
# $`Frame R2`
# [1] "AS"
#
# $`Frame R3`
# [1] "LAS"
}
