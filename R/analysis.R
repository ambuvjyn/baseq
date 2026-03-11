#' Count Bases
#'
#' Returns a frequency table of the bases in a sequence.
#'
#' @param s A character string containing the sequence
#' @return A table object with base counts
#' @examples
#' data(sars_fragment)
#' count_bases(sars_fragment)
#' @export
count_bases <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(table(NULL))
  table(strsplit(toupper(s), "")[[1]])
}

#' Count Pattern
#'
#' Counts the occurrences of a specific pattern in a sequence.
#'
#' @param s A character string containing the sequence
#' @param p A character string containing the pattern to count
#' @return Integer count of occurrences
#' @examples
#' data(sars_fragment)
#' count_pattern(sars_fragment, "ATTA")
#' @export
count_pattern <- function(s, p) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  m <- gregexpr(p, toupper(s), fixed = TRUE)[[1]]
  if (m[1] == -1) return(0)
  length(m)
}

#' GC Content
#'
#' Calculates the percentage of G and C bases in a DNA sequence.
#'
#' @param s A character string containing the sequence
#' @return Numeric percentage of GC content
#' @examples
#' data(sars_fragment)
#' gc_content(sars_fragment)
#' @export
gc_content <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  s <- toupper(s)
  (nchar(gsub("[^GC]", "", s)) / nchar(s)) * 100
}

#' Assembly Stats
#'
#' Computes N50, L50, and other assembly statistics.
#'
#' @param seqs A character vector or list of sequences (contigs)
#' @return A named numeric vector of statistics
#' @examples
#' contigs <- c("ATGC", "ATGCATGC", "ATGCATGCATGC")
#' calculate_assembly_stats(contigs)
#' @export
calculate_assembly_stats <- function(seqs) {
  if (is.null(seqs) || length(seqs) == 0) return(NULL)
  lens <- sort(if(is.list(seqs)) sapply(seqs, nchar) else nchar(seqs), decreasing=T)
  lens <- lens[!is.na(lens)]
  if (length(lens) == 0) return(NULL)
  cs <- cumsum(lens); tot <- sum(lens)
  idx <- which(cs >= tot*0.5)[1]
  c(Total=tot, Count=length(lens), Max=lens[1], N50=lens[idx], L50=idx)
}

#' K-mer Counting
#'
#' Counts all possible substrings of length k.
#'
#' @param s A character string containing the sequence
#' @param k Integer length of k-mer
#' @return A table of k-mer counts
#' @examples
#' data(sars_fragment)
#' count_kmers(sars_fragment, k = 3)
#' @export
count_kmers <- function(s, k=3) {
  if (is.null(s) || is.na(s) || nchar(s) < k) return(table(NULL))
  table(substring(toupper(s), 1:(nchar(s)-k+1), k:nchar(s)))
}

#' Codon Usage RSCU
#'
#' Calculates Relative Synonymous Codon Usage (RSCU).
#'
#' @param s A character string containing the coding DNA sequence
#' @return A dataframe with codon statistics
#' @examples
#' data(sars_fragment)
#' calculate_codon_usage(sars_fragment)
#' @export
calculate_codon_usage <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) < 3) return(NULL)
  gc <- get_genetic_code(); s <- toupper(s)
  cods <- substring(s, seq(1, nchar(s)-2, 3), seq(3, nchar(s), 3))
  counts <- table(cods)
  df <- data.frame(Codon=names(gc), AA=unname(gc), Freq=0, RSCU=0, stringsAsFactors=F)
  for(c in names(counts)) if(c %in% df$Codon) df$Freq[df$Codon==c] <- counts[c]
  for(aa in unique(df$AA)) {
    idx <- which(df$AA==aa); sc <- sum(df$Freq[idx])
    if(sc > 0) df$RSCU[idx] <- df$Freq[idx] / (sc / length(idx))
  }
  return(df)
}

#' Sequence Identity
#'
#' Compares two sequences of equal length.
#'
#' @param s1 First sequence
#' @param s2 Second sequence
#' @return A list with Identity percentage and Hamming Distance
#' @examples
#' calculate_identity("ATGC", "ATGG")
#' @export
calculate_identity <- function(s1, s2) {
  if (is.null(s1) || is.na(s1) || is.null(s2) || is.na(s2)) stop("Valid sequences required.")
  if (nchar(s1) != nchar(s2)) {
    stop("Sequences must have the same length for simple identity calculation.\n",
         "Tip: For sequences of different lengths, you need 'Global Alignment'.\n",
         "Consider using the 'Biostrings' package (BiocManager::install('Biostrings')).")
  }
  if (nchar(s1) == 0) return(list(Identity=100, Distance=0))
  m <- (strsplit(toupper(s1),"")[[1]] == strsplit(toupper(s2),"")[[1]])
  list(Identity=(sum(m)/length(m))*100, Distance=sum(!m))
}

#' FASTA Summary
#'
#' Generates a comprehensive summary of a multi-FASTA file.
#'
#' @param file Path to the FASTA file
#' @return A summary dataframe
#' @examples
#' \donttest{
#' # summarize_fasta("path/to/my.fasta")
#' }
#' @export
summarize_fasta <- function(file) {
  if (!file.exists(file)) stop("File not found.")
  df <- read_seq(file); if(is.null(df) || nrow(df)==0) return(data.frame())
  res <- data.frame(Name=df$Header, Length=nchar(df$Sequence), GC=sapply(df$Sequence, gc_content), ORF=0, MW=0, PI=0, stringsAsFactors=F)
  for(i in 1:nrow(df)) {
    orf <- find_longest_orf(df$Sequence[i]); res$ORF[i] <- nchar(orf)
    if(nchar(orf)>0) { res$MW[i] <- calculate_mw(orf); res$PI[i] <- calculate_pi(orf) }
  }
  return(res)
}
