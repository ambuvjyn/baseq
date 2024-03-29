% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reverse_complement.R
\name{reverse_complement}
\alias{reverse_complement}
\title{Generate Reverse Complement of DNA sequence}
\usage{
reverse_complement(sequence)
}
\arguments{
\item{sequence}{A character string containing the DNA sequence to be reversed and complemented}
}
\value{
A character string containing the reverse complement of the input DNA sequence
}
\description{
Given a DNA sequence, the function generates the reverse complement of the sequence and returns it.
}
\examples{
sequence <- "ATCGAGCTAGCTAGCTAGCTAGCT"
reverse_complement(sequence)
# [1] "AGCTAGCTAGCTAGCTAGCTCGAT"
}
