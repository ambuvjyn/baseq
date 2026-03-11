#' Primer Tm
#'
#' Calculates the melting temperature of a primer sequence.
#'
#' @param s A character string containing the sequence
#' @param salt Numeric salt concentration in mM (default: 50)
#' @return Numeric Tm in Celsius
#' @export
calculate_tm <- function(s, salt=50) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  s <- toupper(s); n <- nchar(s)
  a <- nchar(gsub("[^A]","",s)); t <- nchar(gsub("[^T]","",s))
  c <- nchar(gsub("[^C]","",s)); g <- nchar(gsub("[^G]","",s))
  if(n<14) tm <- 2*(a+t)+4*(g+c) else tm <- 64.9+41*(g+c-16.4)/n
  round(tm, 2)
}

#' Protein MW
#'
#' Calculates the molecular weight of a protein sequence.
#'
#' @param s A character string containing the protein sequence
#' @return Numeric molecular weight in Daltons
#' @export
calculate_mw <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  s <- toupper(s)
  w <- c(A=71.07, R=156.18, N=114.10, D=115.08, C=103.13, E=129.11, Q=128.13, G=57.05, H=137.14, I=113.15, L=113.15, K=128.17, M=131.19, F=147.17, P=97.11, S=87.07, T=101.10, W=186.21, Y=163.17, V=99.13)
  res <- w[strsplit(s,"")[[1]]]; round(sum(res[!is.na(res)], na.rm=T)+18.01, 2)
}

#' Protein pI
#'
#' Estimates the isoelectric point of a protein sequence.
#'
#' @param s A character string containing the protein sequence
#' @return Numeric pI value
#' @export
calculate_pi <- function(s) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(7.0)
  s <- toupper(s); pka <- c(R=12,K=10,H=5.98,D=4.05,E=4.45,C=9,Y=10)
  cnt <- sapply(names(pka), function(aa) nchar(gsub(paste0("[^",aa,"]"),"",s)))
  low <- 0; high <- 14; mid <- 7.0
  for(i in 1:20) {
    mid <- (low+high)/2
    ch <- 1/(10^(mid-7.5)+1) + sum(cnt[c("R","K","H")]*(1/(10^(mid-pka[c("R","K","H")])+1)))
    ch <- ch - (1/(10^(3.55-mid)+1) + sum(cnt[c("D","E","C","Y")]*(1/(10^(pka[c("D","E","C","Y")]-mid)+1))))
    if(ch>0) low <- mid else high <- mid
  }
  round(mid, 2)
}

#' Protein Net Charge
#'
#' Calculates the net electrical charge of a protein at a given pH.
#'
#' @param s A character string containing the protein sequence
#' @param ph Numeric pH value (default: 7.4)
#' @return Numeric net charge
#' @export
calculate_charge <- function(s, ph=7.4) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  s <- toupper(s); pka <- c(R=12,K=10,H=5.98,D=4.05,E=4.45,C=9,Y=10)
  cnt <- sapply(names(pka), function(aa) nchar(gsub(paste0("[^",aa,"]"),"",s)))
  ch <- 1/(10^(ph-7.5)+1) + sum(cnt[c("R","K","H")]*(1/(10^(ph-pka[c("R","K","H")])+1)))
  ch <- ch - (1/(10^(3.55-ph)+1) + sum(cnt[c("D","E","C","Y")]*(1/(10^(pka[c("D","E","C","Y")]-ph)+1))))
  round(ch, 3)
}

#' Virtual Digestion
#'
#' Simulates restriction enzyme digestion.
#'
#' @param s A character string containing the DNA sequence
#' @param p A character string containing the restriction site (regex)
#' @return A numeric vector of fragment lengths
#' @export
simulate_digestion <- function(s, p) {
  if (is.null(s) || is.na(s) || nchar(s) == 0) return(0)
  s <- toupper(s); m <- gregexpr(p, s, fixed=T)[[1]]
  if(m[1]==-1) return(nchar(s))
  cuts <- as.integer(m); all_cuts <- c(1, cuts, nchar(s)+1)
  diff(all_cuts)
}

#' PCR Simulator
#'
#' Simulates a PCR reaction and predicts amplicon sizes.
#'
#' @param template A character string containing the DNA template
#' @param fwd A character string of the forward primer
#' @param rev_p A character string of the reverse primer
#' @return A numeric vector of amplicon sizes
#' @export
simulate_pcr <- function(template, fwd, rev_p) {
  if (is.null(template) || is.na(template) || nchar(template) == 0) return(0)
  template <- toupper(template); fwd <- toupper(fwd); rev_p <- toupper(rev_p)
  fwd_m <- gregexpr(fwd, template, fixed=T)[[1]]
  rc_temp <- rev_comp(template); rev_m <- gregexpr(rev_p, rc_temp, fixed=T)[[1]]
  if(fwd_m[1]==-1 || rev_m[1]==-1) return(0)
  amplicons <- c()
  for(f in fwd_m) for(r_rc in rev_m) {
    r <- nchar(template) - r_rc + 1
    if(f < r) amplicons <- c(amplicons, r-f+1)
  }
  if(length(amplicons)==0) return(0)
  return(amplicons)
}
