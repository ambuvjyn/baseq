#' Write a FASTQ file from a dataframe of reads
#' 
#' @param df A dataframe containing reads in the format "Header", "Sequence", and "QualityScore".
#' 
#' @return A FASTQ file with the same name as the input dataframe.
#' 
#' @examples
#' sample_file_path_two <- system.file("extdata", "sample_fq.fastq", package = "baseq")
#' read.fastq_to_df(sample_file_path_two)
#' write.df_to_fastq(sample_fq)
#' 
#' @export
write.df_to_fastq <- function(df) {
  # Get the name of the dataframe
  df_name <- deparse(substitute(df))
  
  # Get the name of the output file
  output_file <- paste0(df_name, ".fastq")
  
  # Open the output file for writing
  con <- file(output_file, "w")
  
  # Loop over the dataframe and write each read to the output file
  for (i in 1:nrow(df)) {
    header <- paste0("@", df[i, "Header"])
    sequence <- df[i, "Sequence"]
    quality_score <- df[i, "QualityScore"]
    
    writeLines(header, con)
    writeLines(sequence, con)
    writeLines("+", con)
    writeLines(quality_score, con)
  }
  
  # Close the output file
  close.connection(con)
  
  # Remove the temp file
  file.remove("sample_fq.fastq")
  
  # Print a message indicating successful writing
  cat(sprintf("Dataframe %s written to FASTQ file %s\n", df_name, output_file))
}
