#' Write a FASTQ file from a dataframe of reads
#'
#' @param df A dataframe containing reads in the format "Header", "Sequence", and "QualityScore".
#'
#' @param output_dir An optional argument specifying the directory where the FASTQ file should be saved. If not specified, the file will be saved in the working directory.
#'
#' @return A FASTQ file with the same name as the input dataframe.
#'
#' @examples
#' #sample_file_path_two <- system.file("extdata", "sample_fq.fastq", package = "baseq")
#' #tempdir <- tempdir()
#' #temp_file_path <- file.path(tempdir, basename(sample_file_path_two))
#' #file.copy(sample_file_path_two, temp_file_path, overwrite = TRUE)
#' #read.fastq_to_df(sample_file_path_two)
#' #write.df_to_fastq(sample_fq, output_dir = tempdir)
#'
#' # Write to working directory
#' # write.df_to_fastq(sample_fq)
#'
#' # Write to custom directory
#' # write.df_to_fastq(sample_fq, output_dir = "/path/to/directory/")
#'
#' @export
write.df_to_fastq <- function(df, output_dir = getwd()) {

  #Get the name of the dataframe
  df_name <- deparse(substitute(df))

  #Get the name of the output file
  output_file <- file.path(output_dir, paste0(df_name, ".fastq"))

  #Open the output file for writing
  con <- file(output_file, "w")

  #Loop over the dataframe and write each read to the output file
  for (i in 1:nrow(df)) {
    header <- paste0("@", df[i, "Header"])
    sequence <- df[i, "Sequence"]
    quality_score <- df[i, "QualityScore"]
    writeLines(header, con)
    writeLines(sequence, con)
    writeLines("+", con)
    writeLines(quality_score, con)
  }

  #Close the output file
  close.connection(con)

  #Print a message indicating successful writing
  cat(sprintf("Dataframe %s written to FASTQ file %s\n", df_name, output_file))
}
