#' Convert a FASTQ file to a FASTA file
#'
#' This function converts a FASTQ file to a FASTA file. The output file has the same name as the input
#' FASTQ file, but with the extension changed to `.fasta`. This function removes the `@` symbol at the beginning
#' of FASTQ sequence names and replaces it with the `>` symbol for the FASTA format.
#'
#' @param fastq_file A character string specifying the path to the input FASTQ file.
#' @return A character string specifying the path to the output FASTA file.
#'
#' @examples
#' sample_file_path_two <- system.file("extdata", "sample_fq.fastq", package = "baseq")
#' fastq_to_fasta(sample_file_path_two)
#' # Output: "path/to/library/baseq/extdata/sample_fa.fasta"
#' @export
fastq_to_fasta <- function(fastq_file) {

  # read in fastq file
  fastq_data <- readLines(fastq_file)

  # create output fasta file name
  fasta_file <- sub(".fastq$", ".fasta", fastq_file)

  # open output fasta file for writing
  write_con <- file(fasta_file, open = "w")

  # loop through every 4th line of fastq file
  for (i in seq(1, length(fastq_data), by = 4)) {

    # remove @ from start of sequence name and replace with >
    header <- gsub("^@", ">", fastq_data[i])

    # extract sequence
    seq <- fastq_data[i + 1]

    # write fasta format to output file
    cat(header, "\n", seq, "\n", file = write_con)
  }

  # close output file connection
  close(write_con)

  # return the name of the output fasta file
  return(fasta_file)
}
