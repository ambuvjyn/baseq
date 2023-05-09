#' Calculate statistics from a FASTA dataframe
#'
#' This function takes a FASTA dataframe as input and calculates statistics for each sequence as well as overall statistics for the entire dataset. The output is printed to the console.
#'
#' @param fasta_df A dataframe in which the first column contains the sequence headers and the second column contains the sequences in FASTA format.
#'
#' @examples
#' fasta_df <- data.frame(Header = c(">seq1", ">seq2"), Sequence = c("ATCG", "ATCGAT"))
#' fasta_to_df_stats(fasta_df)
#'
#' @return This function does not return anything. Instead, it prints the statistics to the console.
#'
#' @export
fasta_to_df_stats <- function(fasta_df) {
    # Calculate overall statistics
    n_seqs <- nrow(fasta_df)
    total_bases <- sum(nchar(fasta_df$Sequence))
    gc_count <- sum(unlist(lapply(strsplit(fasta_df$Sequence, ""), function(x) sum(x %in% c("G", "C")))))
    gc_content <- gc_count / total_bases * 100

    # Print overall statistics
    cat(sprintf("Overall Statistics:\nNumber of Sequences: %d\nTotal Bases: %d\nGC Content: %.2f%%\n\n", n_seqs, total_bases, gc_content))

    # Calculate individual statistics for each sequence
    for (i in 1:n_seqs) {
      seq_name <- fasta_df[i, "Header"]
      seq_length <- nchar(fasta_df[i, "Sequence"])
      seq_bases <- fasta_df[i, "Sequence"]
      seq_gc_count <- sum(strsplit(seq_bases, "")[[1]] %in% c("G", "C"))
      seq_gc_content <- seq_gc_count / seq_length * 100

      # Print individual statistics
      cat(sprintf("\n%s\n", paste(rep("-", 50), collapse = "")))
      cat(sprintf("Sequence : %s\nLength: %d\nGC Content: %.2f%%\nBase Counts:\n", seq_name, seq_length, seq_gc_content))
      base_counts <- table(strsplit(seq_bases, "")[[1]])
      print(base_counts)
      cat("\n")
    }
  }
