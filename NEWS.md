# baseq 0.2.0
* Replaced slow loops with highly optimized, vectorized functions for sequence translation, cleaning, and file reading.
* Introduced universal wrappers (`clean_seq`, `read_seq`, `write_seq`, `rev_comp`) to simplify workflows, along with `snake_case` aliases (`clean_dna_seq`, `clean_rna_seq`) while maintaining backward compatibility.
* Added `find_longest_orf`, `find_cpg_islands`, `search_motif`, `shuffle_sequence`, and robust sequence simulators (`simulate_sequence`, `simulate_fasta`, `simulate_fastq`).
* Added `calculate_tm`, `calculate_mw`, `calculate_pi`, `calculate_charge`, and `simulate_pcr`, `simulate_digestion`.
* Added publication-ready `ggplot2` functions (`plot_gc_skew`, `plot_hydrophobicity`, `plot_aa_composition`, `plot_dotplot`).
* Added `baseq_dna` and `baseq_rna` object classes and `translate()` S3 method. Added `as_Biostrings` bridge.
* Added a comprehensive `testthat` suite with 30+ passing categories handling edge cases (NA/NULL handling, blank inputs, malformed files).

# baseq 0.1.4
* Addressed CRAN feedback.

# baseq 0.1.3
* Updated README
* Updated Examples with executable sample files

# baseq 0.1.2
* Added 2 new functions
* Updated README

# baseq 0.1.1
* Added 14 new functions
* Updated README

# baseq 0.1.0
* Added a `NEWS.md` file to track changes to the package.
