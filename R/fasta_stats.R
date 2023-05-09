#' Calculate basic statistics for multi-fasta sequences
#'
#' This function reads in a multi-fasta file and calculates sequence statistics such as sequence length, GC content, and base counts for each sequence.
#'
#' @param file_path A character string specifying the path to the multi-fasta file to be analyzed.
#'
#' @return A list of named lists containing sequence statistics for each sequence in the multi-fasta file.
#'
#' @details This function reads in a multi-fasta file specified by {file_path} and calculates various statistics for each sequence. The statistics include the length of the sequence, GC content, and counts of each base type (A, C, G, T). The results are returned as a list of named lists, with each element of the list corresponding to a single sequence in the multi-fasta file.
#'
#' @examples
#' # fasta_stats("example.fasta")
#'
#' @export
fasta.stats <- function(file_path) {
  # Read in the multi-fasta file
  fasta_data <- readLines(file_path)
  # Initialize an empty list to store results for each sequence
  results <- list()
  # Initialize sequence counter
  seq_count <- 0
  # Loop over the lines in the fasta file
  for (i in 1:length(fasta_data)) {
    if (grepl("^>", fasta_data[i])) {
      # If a new sequence header is found, increment the sequence counter
      seq_count <- seq_count + 1
      # Initialize a new element in the results list for this sequence
      results[[seq_count]] <- list()
      # Store the sequence header in the results list
      results[[seq_count]]$header <- fasta_data[i]
      # Initialize an empty character vector to store the sequence data
      results[[seq_count]]$seq <- character()
    } else {
      # If sequence data is found, add it to the appropriate element in the results list
      results[[seq_count]]$seq <- paste0(results[[seq_count]]$seq, fasta_data[i])
    }
  }
  # Loop over the elements in the results list and calculate sequence statistics
  for (i in 1:length(results)) {
    # Extract sequence data
    seq_data <- results[[i]]$seq
    # Calculate sequence length
    seq_length <- nchar(seq_data)
    # Calculate GC content
    gc_content <- (length(grep("[GCgc]", seq_data)) / seq_length) * 100
    # Count occurrences of each base
    base_counts <- table(strsplit(seq_data, "")[[1]])
    # Store results in the appropriate element of the results list
    results[[i]]$seq_length <- seq_length
    results[[i]]$gc_content <- gc_content
    results[[i]]$base_counts <- base_counts
  }
  # Return results as a list of named lists
  for (i in 1:length(results)) {
    cat("\nSequence ", i, ":\n")
    header_name <- gsub(">", "", results[[i]]$header)
    cat("Header: ", header_name, "\n")
    cat("Length: ", results[[i]]$seq_length, "\n")
    cat("GC Content: ", results[[i]]$gc_content, "\n")
    cat("Base Counts:\n")
    print(results[[i]]$base_counts)
  }
}

#' @rdname fasta.stats
#' @export
fasta_stats <- fasta.stats
