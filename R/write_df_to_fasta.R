#' Write a data frame to a fasta file
#'
#' This function writes a data frame to a fasta file with the same name as the data frame. The data frame is assumed to have two columns, "Header" and "Sequence", which represent the header and sequence lines of each fasta record, respectively.
#'
#' @param df A data frame containing fasta records with "Header" and "Sequence" columns.
#'
#' @param output_dir The directory path where the output file should be written. If not provided, the working directory will be used.
#'
#' @return This function does not return a value, but writes a fasta file to the specified output directory or the working directory.
#'
#'
#' @examples
#' #sample_file_path <- system.file("extdata", "sample_fa.fasta", package = "baseq")
#' #tempdir <- tempdir()
#' #temp_file_path <- file.path(tempdir, basename(sample_file_path))
#' #file.copy(sample_file_path, temp_file_path, overwrite = TRUE)
#' #read.fasta_to_df(sample_file_path)
#' #write.df_to_fasta(sample_fa, output_dir = tempdir)
#'
#' # Write to working directory
#' # write.df_to_fasta(sample_fa)
#'
#' # Write to custom directory
#' # write.df_to_fasta(sample_fa, output_dir = "/path/to/directory/")
#'
#' @export
write.df_to_fasta <- function(df, output_dir = getwd()) {

  #Get the name of the data frame
  df_name <- deparse(substitute(df))

  #Add .fasta extension to the name
  fasta_name <- paste0(df_name, ".fasta")

  #Construct the full output path
  output_path <- file.path(output_dir, fasta_name)

  #Open the fasta file for writing
  con <- file(output_path, "w")

  #Write each record to the fasta file
  for (i in 1:nrow(df)) {
    header <- paste0(">", df$Header[i])
    sequence <- df$Sequence[i]
    writeLines(c(header, sequence), con)
  }

  #Close the file
  close.connection(con)

  #Print a message indicating successful write
  cat(sprintf("Data frame %s written to fasta file %s\n", df_name, output_path))
}
