#' Write a data frame to a fasta file
#'
#' This function writes a data frame to a fasta file with the same name as the data frame. The data frame is assumed to have two columns, "Header" and "Sequence", which represent the header and sequence lines of each fasta record, respectively.
#'
#' @param df A data frame containing fasta records with "Header" and "Sequence" columns.
#'
#' @return This function does not return a value, but writes a fasta file to the working directory.
#'
#'
#' @examples
#' 
#' sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' read.fasta_to_df(sample_file_path)
#' 
#' write.df_to_fasta(sample_fa)
#'
#' @export
write.df_to_fasta <- function(df) {
  # Get the name of the data frame
  df_name <- deparse(substitute(df))
  
  # Add .fasta extension to the name
  fasta_name <- paste0(df_name, ".fasta")
  
  # Open the fasta file for writing
  con <- file(fasta_name, "w")
  
  # Write each record to the fasta file
  for (i in 1:nrow(df)) {
    header <- paste0(">", df$Header[i])
    sequence <- df$Sequence[i]
    writeLines(c(header, sequence), con)
  }
  
  # Close the file
  close.connection(con)
  
  # Remove the temp file
  file.remove("sample_fa.fasta")
  
  # Print a message indicating successful write
  cat(sprintf("Data frame %s written to fasta file %s\n", df_name, fasta_name))
}
