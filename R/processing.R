#' Universal Sequence Cleaner
#'
#' Removes non-standard characters from DNA or RNA sequences.
#'
#' @param sequence A character string containing the sequence
#' @param type A string "DNA", "RNA", or "auto"
#' @return A character string of the cleaned sequence
#' @export
clean_seq <- function(sequence, type = "auto") {
  if (is.null(sequence) || is.na(sequence)) return("")
  sequence <- toupper(sequence)
  if (type == "auto") {
    if (nchar(sequence) == 0) type <- "DNA"
    else type <- if (grepl("U", sequence)) "RNA" else "DNA"
  }
  pattern <- if (type == "RNA") "[^ACGU]" else "[^ACGT]"
  return(gsub(pattern, "", sequence))
}

#' Batch File Cleaner
#'
#' Cleans all sequences in a FASTA or FASTQ file.
#'
#' @param input_file Path to input file
#' @param type Sequence type ("DNA", "RNA", or "auto")
#' @param output_dir Optional output directory
#' @return Path to the cleaned file
#' @export
clean_file <- function(input_file, type = "auto", output_dir = "") {
  data <- read_seq(input_file, format = "df")
  if (nrow(data) == 0) return(NULL)
  data$Sequence <- sapply(data$Sequence, clean_seq, type = type)
  if (output_dir == "") output_dir <- dirname(input_file)
  out <- file.path(output_dir, paste0(tools::file_path_sans_ext(basename(input_file)), "_clean.fasta"))
  write_seq(data, out)
  return(out)
}

#' Quality Filter FASTQ
#'
#' Filters FASTQ reads based on average quality score.
#'
#' @param input_file Path to input FASTQ
#' @param output_file Path to output FASTQ
#' @param min_avg_quality Minimum average Phred score (default: 20)
#' @param phred_offset Phred offset (default: 33)
#' @export
filter_fastq_quality <- function(input_file, output_file, min_avg_quality = 20, phred_offset = 33) {
  if (!file.exists(input_file)) stop("File not found.")
  con_in <- file(input_file, "r"); con_out <- file(output_file, "w")
  on.exit({ close(con_in); close(con_out) })
  passed <- 0; total <- 0
  while (length(h <- readLines(con_in, 1)) > 0) {
    s <- readLines(con_in, 1); p <- readLines(con_in, 1); q <- readLines(con_in, 1); total <- total + 1
    if (length(q) == 0) break
    qual_scores <- as.numeric(charToRaw(q)) - phred_offset
    if (mean(qual_scores, na.rm = TRUE) >= min_avg_quality) {
      writeLines(c(h, s, p, q), con_out); passed <- passed + 1
    }
  }
  cat("Filtering complete:", passed, "/", total, "passed.\n")
}
