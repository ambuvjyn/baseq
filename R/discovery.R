#' Find Longest ORF
#'
#' Scans a DNA sequence in all 6 reading frames to find the longest open reading frame.
#'
#' @param s A character string containing the DNA sequence
#' @return A character string of the longest translated protein sequence
#' @export
find_longest_orf <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) < 3) return("")
  s <- toupper(s); gc <- get_genetic_code()
  trans <- function(seq) {
    if(nchar(seq) < 3) return("")
    codons <- substring(seq, seq(1, nchar(seq)-2, 3), seq(3, nchar(seq), 3))
    res <- gc[codons]; st <- which(res == "*")
    if (length(st) > 0) res <- res[1:(st[1]-1)]
    paste(res, collapse="")
  }
  rc <- rev_comp(s)
  frames <- list(s, substring(s,2), substring(s,3), rc, substring(rc,2), substring(rc,3))
  all_orfs <- c()
  for(f in frames) {
    aa <- trans(f); matches <- regmatches(aa, gregexpr("M[^*]*", aa))[[1]]
    all_orfs <- c(all_orfs, matches)
  }
  if(length(all_orfs)==0) return(""); all_orfs[which.max(nchar(all_orfs))]
}

#' CpG Island Detection
#'
#' Identifies candidate CpG islands in a DNA sequence.
#'
#' @param s A character string containing the DNA sequence
#' @param window Sliding window size (default: 200)
#' @return A dataframe with start and end positions
#' @export
find_cpg_islands <- function(s, window=200) {
  if (is.null(s) || is.na(s) || nchar(s) < window) return(data.frame(Start=integer(0), End=integer(0)))
  s <- toupper(s); n <- nchar(s)
  starts <- seq(1, n-window+1, 50)
  is_isl <- sapply(starts, function(st) {
    win <- substr(s, st, st+window-1); g <- nchar(gsub("[^G]","",win)); c <- nchar(gsub("[^C]","",win))
    obs <- length(gregexpr("CG", win)[[1]]); exp <- (c*g)/window
    ( (g+c)/window >= 0.5 && (if(exp>0) obs/exp else 0) >= 0.6 )
  })
  if(!any(is_isl)) return(data.frame(Start=integer(0), End=integer(0)))
  data.frame(Start=starts[is_isl], End=starts[is_isl]+window)
}

#' Motif Searching
#'
#' Finds all occurrences of a motif in a sequence.
#'
#' @param s A character string containing the sequence
#' @param p A character string containing the motif (regex)
#' @return A dataframe with the Start, End, and Match string
#' @export
search_motif <- function(s, p) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(data.frame(Start=integer(0), End=integer(0), Match=character(0)))
  m <- gregexpr(p, s, perl=T, ignore.case=T)[[1]]
  if(m[1]==-1) return(data.frame(Start=integer(0), End=integer(0), Match=character(0)))
  data.frame(Start=as.integer(m), End=as.integer(m)+attr(m,"match.length")-1, Match=substring(s, m, as.integer(m)+attr(m,"match.length")-1), stringsAsFactors=F)
}

#' Shuffle Sequence
#'
#' Randomly permutes the characters of a sequence.
#'
#' @param s A character string containing the sequence
#' @return A character string of the shuffled sequence
#' @export
shuffle_sequence <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return("")
  paste(sample(strsplit(s,"")[[1]]), collapse="")
}

#' Simulate Sequence
#'
#' Generates a random DNA or RNA sequence.
#'
#' @param len Integer length of the sequence
#' @param gc Numeric target GC content (0 to 1)
#' @param type "DNA" or "RNA"
#' @return A character string of the simulated sequence
#' @export
simulate_sequence <- function(len, gc=NULL, type="DNA") {
  if (is.null(len) || is.na(len) || len <= 0) return("")
  bases <- if (toupper(type) == "RNA") c("A","U","C","G") else c("A","T","C","G")
  if(is.null(gc)) return(paste(sample(bases, len, T), collapse=""))
  probs <- c((1-gc)/2, (1-gc)/2, gc/2, gc/2)
  paste(sample(bases, len, T, probs), collapse="")
}

#' Simulate FASTA File
#'
#' Generates a dummy FASTA dataset.
#'
#' @param n_seq Number of sequences
#' @param seq_len Length of each sequence
#' @param gc Target GC content
#' @param type "DNA" or "RNA"
#' @param file Optional file path to save
#' @return A dataframe of simulated sequences
#' @export
simulate_fasta <- function(n_seq = 5, seq_len = 100, gc = NULL, type = "DNA", file = NULL) {
  df <- data.frame(
    Header = paste0("Simulated_Seq_", 1:n_seq),
    Sequence = sapply(1:n_seq, function(i) simulate_sequence(seq_len, gc, type)),
    stringsAsFactors = FALSE
  )
  if (!is.null(file)) write_seq(df, file)
  return(df)
}

#' Simulate FASTQ File
#'
#' Generates a dummy FASTQ dataset.
#'
#' @param n_reads Number of reads
#' @param read_len Length of each read
#' @param gc Target GC content
#' @param type "DNA" or "RNA"
#' @param file Optional file path to save
#' @return A dataframe of simulated reads
#' @export
simulate_fastq <- function(n_reads = 5, read_len = 100, gc = NULL, type = "DNA", file = NULL) {
  df <- data.frame(
    Header = paste0("Simulated_Read_", 1:n_reads),
    Sequence = sapply(1:n_reads, function(i) simulate_sequence(read_len, gc, type)),
    QualityScore = sapply(1:n_reads, function(i) paste(sample(strsplit("!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJ", "")[[1]], size = read_len, replace = TRUE), collapse = "")),
    stringsAsFactors = FALSE
  )
  if (!is.null(file)) write_seq(df, file)
  return(df)
}
