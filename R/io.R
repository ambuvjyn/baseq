#' Universal Sequence Reader
#'
#' Reads a FASTA or FASTQ file and returns it as a dataframe or list.
#'
#' @param file Path to the input sequence file
#' @param format A string indicating "df" (dataframe) or "list" (default: "df")
#' @return A dataframe or list of the sequence data.
#' @export
read_seq <- function(file, format = "df") {
  if (!file.exists(file)) stop("File not found: ", file)
  ext <- tolower(tools::file_ext(file))
  
  if (ext %in% c("fasta", "fa")) {
    lines <- readLines(file, warn = FALSE)
    if (length(lines) == 0) return(if(format=="df") data.frame(Header=character(), Sequence=character(), stringsAsFactors=F) else list())
    
    header_idx <- which(grepl("^>", lines))
    if (length(header_idx) == 0) stop("No headers found in FASTA.")
    
    headers <- gsub("^>", "", lines[header_idx])
    sequences <- character(length(header_idx))
    for (i in seq_along(header_idx)) {
      start <- header_idx[i] + 1
      end <- if (i < length(header_idx)) header_idx[i+1] - 1 else length(lines)
      sequences[i] <- if (start <= end) paste(lines[start:end], collapse = "") else ""
    }
    
    if (format == "df") return(data.frame(Header = headers, Sequence = sequences, stringsAsFactors = FALSE))
    res <- as.list(sequences); names(res) <- headers; return(res)
    
  } else if (ext %in% c("fastq", "fq")) {
    lines <- readLines(file, warn = FALSE)
    if (length(lines) == 0) return(if(format=="df") data.frame(Header=character(), Sequence=character(), QualityScore=character(), stringsAsFactors=F) else list())
    
    num_records <- length(lines) %/% 4
    if (num_records == 0) return(if(format=="df") data.frame() else list())
    
    headers <- gsub("^@", "", lines[seq(1, by = 4, length.out = num_records)])
    sequences <- lines[seq(2, by = 4, length.out = num_records)]
    quality <- lines[seq(4, by = 4, length.out = num_records)]
    
    if (format == "df") {
      return(data.frame(Header = headers, Sequence = sequences, QualityScore = quality, stringsAsFactors = FALSE))
    }
    res <- lapply(seq_len(num_records), function(i) list(Sequence = sequences[i], QualityScore = quality[i]))
    names(res) <- headers; return(res)
  }
  stop("Unsupported file extension.")
}

#' Universal Sequence Writer
#'
#' Writes a sequence object (dataframe or list) to a FASTA or FASTQ file.
#'
#' @param x A sequence object (dataframe or list)
#' @param file Path to the output sequence file
#' @return Invisible TRUE
#' @export
write_seq <- function(x, file) {
  if (is.null(x) || (is.data.frame(x) && nrow(x) == 0) || (is.list(x) && length(x) == 0)) {
    warning("Input object is empty. Nothing to write.")
    return(invisible(FALSE))
  }
  
  ext <- tolower(tools::file_ext(file))
  con <- file(file, "w")
  on.exit(close(con))
  
  if (ext %in% c("fasta", "fa")) {
    if (is.data.frame(x)) {
      for (i in 1:nrow(x)) {
        writeLines(paste0(">", x$Header[i]), con)
        writeLines(x$Sequence[i], con)
      }
    } else {
      nm <- names(x)
      for (i in seq_along(x)) {
        writeLines(paste0(">", if(!is.null(nm)) nm[i] else paste0("seq", i)), con)
        item <- x[[i]]
        seq <- if(is.list(item)) item$Sequence else item
        writeLines(seq, con)
      }
    }
  } else if (ext %in% c("fastq", "fq")) {
    if (is.data.frame(x)) {
      for (i in 1:nrow(x)) {
        writeLines(paste0("@", x$Header[i]), con)
        writeLines(x$Sequence[i], con)
        writeLines("+", con)
        writeLines(x$QualityScore[i], con)
      }
    } else {
      nm <- names(x)
      for (i in seq_along(x)) {
        writeLines(paste0("@", if(!is.null(nm)) nm[i] else paste0("seq", i)), con)
        item <- x[[i]]
        seq <- if(is.list(item)) item$Sequence else item
        qual <- if(is.list(item) && !is.null(item$QualityScore)) item$QualityScore else paste(rep("I", nchar(seq)), collapse="")
        writeLines(seq, con); writeLines("+", con); writeLines(qual, con)
      }
    }
  } else {
    stop("Unsupported output extension.")
  }
  cat("File written to", file, "\n")
  invisible(TRUE)
}

#' Convert FASTQ to FASTA
#'
#' Converts a FASTQ file to FASTA format.
#'
#' @param fastq_file Path to input FASTQ
#' @return Path to output FASTA
#' @export
fastq_to_fasta <- function(fastq_file) {
  data <- read_seq(fastq_file, format = "df")
  fasta_file <- sub("\\.fastq$", ".fasta", fastq_file)
  write_seq(data, fasta_file)
  return(fasta_file)
}
