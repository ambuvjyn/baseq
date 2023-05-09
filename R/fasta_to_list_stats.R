#' Compute statistics for each sequence in a FASTA list
#'
#' This function computes various statistics for each sequence in a FASTA list,
#' including sequence length, GC content, and base counts.
#'
#' @param fasta_list A named list containing DNA sequences in FASTA format.
#'
#' @return A list containing statistics for each sequence in the input FASTA list.
#' Each element in the returned list is itself a list containing the header,
#' sequence length, GC content, and base counts for a single sequence.
#'
#' @examples
#' # Compute statistics for each sequence in the list
#' # fasta_to_list_stats(fasta_list)
#'
#' @export
fasta_to_list_stats <- function(fasta_list) {
  # Initialize an empty list to store results
  results <- list()

  # Loop over the sequences in the fasta list
  for (seq_name in names(fasta_list)) {
    sequence <- fasta_list[[seq_name]]
    seq_length <- nchar(sequence)
    base_counts <- table(strsplit(sequence, "")[[1]])
    gc_content <- sum(base_counts[c("G", "C")]) / sum(base_counts)

    # Store the results as a named list and add it to the overall results list
    seq_results <- list(header = seq_name, seq_length = seq_length, gc_content = gc_content, base_counts = base_counts)
    results <- c(results, list(seq_results))

    # Print the results for the current sequence
    cat(sprintf("\n%s\n", paste(rep("-", 50), collapse = "")))
    cat(sprintf("Sequence: %s\n", seq_name))
    cat(sprintf("Length:   %s\n", seq_length))
    cat(sprintf("GC Content: %.2f\n", gc_content))
    cat("Base Counts:\n")
    print(base_counts)
  }

}
