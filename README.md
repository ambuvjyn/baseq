
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/baseq)](https://cran.r-project.org/package=baseq)
<!-- badges: end -->


# baseq (v0.2.0)
### Basic Sequence Processing Tool for Biological Data

Developed by Ambu Vijayan and Dr. J. Sreekumar

`baseq` is a comprehensive "Molecular Biology Starter Kit" for R. It provides simple, efficient, and well-tested functions for common tasks in sequence processing, analysis, and visualization.

## 🚀 Quick Reference (Cheat Sheet)

| Task | Function | Description |
| :--- | :--- | :--- |
| **I/O** | `read_seq()` | Reads FASTA/FASTQ into DataFrames or Lists. |
| | `write_seq()` | Writes DataFrames/Lists to FASTA/FASTQ. |
| **Cleaning** | `clean_seq()` | Auto-detects DNA/RNA and removes non-bases. |
| | `filter_fastq_quality()` | Filters large FASTQ files by Phred score. |
| **Central Dogma** | `dna_to_protein()` | 6-frame translation (optimized). |
| | `rev_comp()` | Universal reverse complement (DNA/RNA). |
| | `dna_to_rna()` | Transcription (T -> U). |
| **Discovery** | `find_longest_orf()` | Scans all frames for the longest gene. |
| | `search_motif()` | Finds regex motifs with coordinates. |
| | `summarize_fasta()` | Returns a "Genomic Report Card" for a file. |
| **Lab Math** | `calculate_tm()` | PCR Primer melting temperature. |
| | `calculate_mw()` | Protein molecular weight (Daltons). |
| | `simulate_pcr()` | Predicts PCR amplicon size from primers. |
| **Plots** | `plot_gc_skew()` | Visualizes G-C distribution. |
| | `plot_dotplot()` | Visual comparison of two sequences. |

## New in Version 0.2.0
*   **Performance:** Core functions are now vectorized and significantly faster.
*   **Unified API:** Smart wrappers like `read_seq` and `clean_seq` auto-detect your data.
*   **Discovery:** Added ORF finding, Assembly stats, and wet-lab simulators.
*   **Visuals:** New publication-quality plots using `ggplot2`.

## Installation
```r
# Install from CRAN (v0.1.4)
install.packages("baseq")

# Install the latest dev version (v0.2.0)
# devtools::install_github("ambuvjyn/baseq")
```

## Getting Started
See the package vignette:
```r
vignette("baseq-vignette", package = "baseq")
```
