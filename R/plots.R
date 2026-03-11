#' Plot GC Skew
#'
#' Generates a sliding window plot of GC skew (G-C)/(G+C).
#'
#' @param s A character string containing the DNA sequence
#' @param window Integer window size (default: 100)
#' @return A ggplot object
#' @examples
#' data(sars_fragment)
#' plot_gc_skew(sars_fragment, window = 100)
#' @export
plot_gc_skew <- function(s, window=100) {
  if(!requireNamespace("ggplot2", quietly=T)) stop("ggplot2 required.")
  if (is.null(s) || is.na(s)) stop("Valid sequence required.")
  s <- toupper(s); n <- nchar(s); if(n<window) stop("Sequence too short.")
  step <- max(1, n%/%500); starts <- seq(1, n-window+1, by=step)
  skew <- sapply(starts, function(st) {
    win <- strsplit(substr(s, st, st+window-1),"")[[1]]
    g <- sum(win=="G"); c <- sum(win=="C")
    if(g+c==0) 0 else (g-c)/(g+c)
  })
  ggplot2::ggplot(data.frame(Pos=starts, Skew=skew), ggplot2::aes(x=Pos, y=Skew)) +
    ggplot2::geom_line(color="#0072B2") + ggplot2::theme_minimal() +
    ggplot2::labs(title="GC Skew", x="Position", y="(G-C)/(G+C)")
}

#' Plot Hydrophobicity
#'
#' Generates a sliding window plot of protein hydrophobicity using the Kyte-Doolittle scale.
#'
#' @param s A character string containing the protein sequence
#' @param window Integer window size (default: 9)
#' @return A ggplot object
#' @examples
#' prot <- "MKFLVLALAL"
#' plot_hydrophobicity(prot, window = 3)
#' @export
plot_hydrophobicity <- function(s, window=9) {
  if(!requireNamespace("ggplot2", quietly=T)) stop("ggplot2 required.")
  if (is.null(s) || is.na(s)) stop("Valid sequence required.")
  s <- toupper(s); n <- nchar(s); if(n<window) stop("Sequence too short.")
  scale <- c(I=4.5, V=4.2, L=3.8, F=2.8, C=2.5, M=1.9, A=1.8, G=-0.4, T=-0.7, S=-0.8, W=-0.9, Y=-1.3, P=-1.6, H=-3.2, E=-3.5, Q=-3.5, D=-3.5, N=-3.5, K=-3.9, R=-4.5)
  vals <- scale[strsplit(s,"")[[1]]]; starts <- 1:(n-window+1)
  avgs <- sapply(starts, function(st) mean(vals[st:(st+window-1)], na.rm=T))
  ggplot2::ggplot(data.frame(Pos=starts+window%/%2, Score=avgs), ggplot2::aes(x=Pos, y=Score)) +
    ggplot2::geom_line(color="#009E73") + ggplot2::theme_minimal() +
    ggplot2::labs(title="Hydrophobicity Plot", x="Amino Acid Position", y="Score")
}

#' Plot AA Composition
#'
#' Visualizes the amino acid composition categorized by biochemical properties.
#'
#' @param s A character string containing the protein sequence
#' @return A ggplot object
#' @examples
#' prot <- "MKFLVLALAL"
#' plot_aa_composition(prot)
#' @export
plot_aa_composition <- function(s) {
  if(!requireNamespace("ggplot2", quietly=T)) stop("ggplot2 required.")
  if (is.null(s) || is.na(s)) stop("Valid sequence required.")
  s <- toupper(s); n <- nchar(s); if(n==0) return(NULL)
  grps <- list(Hydrophobic=c("A","V","L","I","M","F","W","P"), Acidic=c("D","E"), Basic=c("R","K","H"), Polar=c("S","T","C","Y","N","Q"), Special="G")
  map <- unlist(lapply(names(grps), function(g) setNames(rep(g, length(grps[[g]])), grps[[g]])))
  df <- as.data.frame(table(Category=map[strsplit(s,"")[[1]]]))
  df$Percentage <- (df$Freq/n)*100
  ggplot2::ggplot(df, ggplot2::aes(x=Category, y=Percentage, fill=Category)) +
    ggplot2::geom_bar(stat="identity") + ggplot2::theme_minimal() +
    ggplot2::labs(title="Amino Acid Composition", y="Percentage (%)")
}

#' Plot Dot Plot
#'
#' Generates a dot plot comparison of two sequences.
#'
#' @param s1 First sequence
#' @param s2 Second sequence
#' @param window Integer word size for matching (default: 1)
#' @return A ggplot object
#' @examples
#' s1 <- "ATGCATGCATGC"
#' s2 <- "ATGCGTGCATGC"
#' plot_dotplot(s1, s2, window = 3)
#' @export
plot_dotplot <- function(s1, s2, window=1) {
  if(!requireNamespace("ggplot2", quietly=T)) stop("ggplot2 required.")
  if (is.null(s1) || is.na(s1) || is.null(s2) || is.na(s2)) stop("Valid sequences required.")
  s1 <- toupper(s1); s2 <- toupper(s2); n1 <- nchar(s1); n2 <- nchar(s2)
  
  if (n1 > 2000 || n2 > 2000) {
    message("Warning: Sequences are large. This plot might be slow.\n",
            "Tip: For very large sequences, consider using 'seqinr::dotPlot()'.")
  }
  
  if(window==1) {
    m <- which(outer(strsplit(s1,"")[[1]], strsplit(s2,"")[[1]], "=="), arr.ind=T)
  } else {
    w1 <- substring(s1, 1:(n1-window+1), window:n1); w2 <- substring(s2, 1:(n2-window+1), window:n2)
    m <- which(outer(w1, w2, "=="), arr.ind=T)
  }
  ggplot2::ggplot(data.frame(S1=m[,1], S2=m[,2]), ggplot2::aes(x=S1, y=S2)) +
    ggplot2::geom_point(shape = 15, size = 0.5) + ggplot2::theme_bw() +
    ggplot2::labs(title="Sequence Dot Plot", x="Seq 1", y="Seq 2") + ggplot2::coord_fixed()
}
