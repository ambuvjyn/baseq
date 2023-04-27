
<!-- README.md is generated from README.Rmd. Please edit that file -->

<a href="https://github.com/ambuvjyn/baseq"><img src="man/figures/logo.png" align="right" height="139"/></a>

<!-- badges: start -->
[![CRAN status](https://www.r-pkg.org/badges/version/baseq)](https://cran.r-project.org/package=baseq)
<!-- badges: end -->


# baseq
### Basic Sequence Processing Tool for Biological Data

Developed by Ambu Vijayan and Dr. J. Sreekumar

Version 0.1.2

Commands :

**Preprocessing :**

* clean_sequence()

* clean_DNA_sequence()

* clean_RNA_sequence()

* clean_DNA_file()

* clean_RNA_file()

* count_bases()

* count_seq_pattern()

* gc_content()

* gc_content_file()

**From DNA :**

* dna_to_protein()

* dna_to_rna()

* reverse_complement()

**From RNA :**

* rna_reverse_complement()

* rna_to_dna()

* rna_to_protein()

**Readers :**

* read_fasta()

* read.fasta_to_df()

* read.fasta_to_list()

* read.fastq_to_list()

**Writers :**

* write.dna_to_rna()

* write.rna_to_dna()

* write.df_to_fasta()

* write.df_to_fastq()

* write.list_to_fasta()

* write.list_to_fastq()

**Converters :**

* fastq_to_fasta()

### Commands are explained below

<p align="justify">
The clean_sequence function is a tool that takes a DNA or RNA sequence as input and removes any characters that are not A, C, G, T (for DNA) or A, C, G, U (for RNA). It returns a character string containing the cleaned sequence. The function takes two parameters: sequence, a character string containing the DNA or RNA sequence to be cleaned, and type, a character string indicating the type of sequence. The default value of type is "DNA". If set to "RNA", the function will remove any characters that are not A, C, G, U. The function returns the cleaned sequence as a character string. The examples show how the function can be used to clean a DNA or RNA sequence.
</p>
<p align="justify">
The count_bases function takes a DNA sequence as a character string and counts the number of A's, C's, G's, and T's in the sequence. The function returns the counts as a named integer vector, where the names of the elements correspond to the nucleotides. This function can be used in bioinformatics applications to analyze DNA sequences and understand their characteristics, such as GC content and motif analysis.
</p>
<p align="justify">
The count_seq_pattern function counts the frequency of a specific character or pattern in a given DNA sequence. The function takes two arguments: seq, a character vector representing the DNA sequence, and pattern, a character string representing the pattern to be counted in the sequence. The function returns an integer representing the count of the pattern in the sequence. The function is case-insensitive as it converts the sequence to uppercase before counting the pattern frequency. The function is useful for various bioinformatics applications, such as identifying sequence motifs and determining the frequency of particular nucleotide sequences.
</p>
<p align="justify">
The gc_content function calculates the percentage of nucleotides in a given DNA sequence that are guanine (G) or cytosine (C), and returns this value as a numeric. The function first checks the input sequence for validity (must be a character string, contain only valid DNA characters), then calculates the GC content by counting the number of G and C nucleotides and dividing by the length of the sequence, and returns the result. This function can be useful in many bioinformatics applications where the GC content of a sequence may be important, such as primer design, genome assembly, or gene expression analysis.
</p>
<p align="justify">
The reverse_complement() function takes a DNA sequence as input, generates the reverse complement of the sequence, and returns it. The function converts the sequence to uppercase, creates a named vector of base complements, and then reverses the sequence and replaces each base with its complement. The resulting reverse complement sequence is then returned as a character string.
</p>
<p align="justify">
The rna_reverse_complement function generates the reverse complement of a given RNA sequence by replacing each base with its complement, which is defined by the complements vector. The function takes a single argument, sequence, which is a character string containing the RNA sequence to be reversed and complemented. The function returns a character string containing the reverse complement of the input RNA sequence. The function is case-insensitive and can handle RNA sequences containing the bases A, C, G, and U.
</p>
<p align="justify">
The dna_to_rna function takes a DNA sequence as input and returns its RNA transcript by replacing all thymine (T) nucleotides with uracil (U) nucleotides. The function is useful in bioinformatics applications that require the conversion of DNA sequences to their corresponding RNA transcripts, such as in gene expression analysis.
</p>
<p align="justify">
The dna_to_protein function is a bioinformatics tool that translates a DNA sequence into its corresponding protein sequences in all six reading frames. It uses a genetic code dictionary to convert the DNA sequence into amino acid sequences. The output is a list of character strings representing the translated protein sequences in all six frames. The function takes a single argument, a character string representing a DNA sequence, and returns a list of the translated protein sequences.
</p>
<p align="justify">
The rna_to_dna function takes a RNA sequence as input and returns its DNA transcript by replacing all Us with Ts. This function takes an RNA sequence as input and returns its DNA complement.
</p>
<p align="justify">
The rna_to_protein function takes an RNA sequence as input and translates it in all six reading frames, producing a list of character strings representing the translated protein sequences. The function defines the genetic code and loops through each frame (1 forward, 2 forward, 3 forward, 1 reverse, 2 reverse, 3 reverse) to translate the sequence in triplets. The resulting protein sequences are stored in a list and returned.
</p>
<p align="justify">
The fastq_to_fasta function converts a FASTQ file to a FASTA file. The @ symbol at the beginning of FASTQ sequence names is removed and replaced with the > symbol for the FASTA format. The output file has the same name as the input FASTQ file, but with the extension changed to .fasta. The function takes a character string specifying the path to the input FASTQ file as input and returns a character string specifying the path to the output FASTA file.
</p>
<p align="justify">
The read.fasta_to_df function reads a fasta file and creates a dataframe with two columns, "Header" and "Sequence". The resulting dataframe is then assigned to the environment with the name same as the fasta file name but without the .fasta extension. The function initializes an empty dataframe, loops over the fasta file, reads in header and sequence lines, and adds the header and sequence lines to the dataframe. The function does not return anything, but assigns the resulting dataframe to the environment.
</p>
<p align="justify">
The read.fasta_to_list function reads a FASTA file and creates a list with two columns: "Header" and "Sequence". The list is then assigned to the environment with the same name as the FASTA file name but without the .fasta extension. The resulting list can be accessed by name in the environment. The function does not return anything, but instead assigns the resulting list to the environment. This function is useful in bioinformatics for reading in sequence data from FASTA files and accessing it easily in R.
</p>
<p align="justify">
The read.fastq_to_df function reads in a Fastq file and stores it as a dataframe with three columns: Header, Sequence, and QualityScore. The function takes a character string specifying the path to the Fastq file to be read, and returns a dataframe with the aforementioned columns. The function loops over the Fastq file, reading in four lines at a time, and adds the four lines to the dataframe. The function then closes the file and assigns the dataframe to the environment. Finally, the function prints a message indicating successful assignment.
</p>
<p align="justify">
The read.fastq_to_list function reads a Fastq file and stores it as a list with three columns: Header, Sequence, and QualityScore. The function takes a character string specifying the path to the Fastq file to be read and returns a list with the aforementioned columns. The function loops over the Fastq file, reads in four lines at a time, removes the @ symbol from the header, and adds the sequence to the list with the header as the list element name. Finally, the function closes the file, assigns the list to the environment, and prints a message indicating successful assignment.
</p>
<p align="justify">
The write.dna_to_rna function takes an input multi FASTA file containing DNA sequences, converts each DNA sequence to RNA sequence, and writes the RNA sequences to a new multi FASTA file with the suffix _rna.fasta.
</p>
<p align="justify">
The write.rna_to_dna function takes an input multi FASTA file containing RNA sequences, converts each RNA sequence to DNA sequence, and writes the DNA sequences to a new multi FASTA file with the suffix _dna.fasta.
</p>
<p align="justify">
The write.df_to_fasta function is used to write a data frame containing FASTA records to a file in the FASTA format. The data frame is assumed to have two columns, "Header" and "Sequence", which represent the header and sequence lines of each FASTA record, respectively. The output file is named after the input data frame with the ".fasta" extension, and is written to the working directory. This function does not return any value but writes a FASTA file to the working directory
</p>
<p align="justify">
The write.df_to_fastq function writes a FASTQ file from a data frame containing reads in the format "Header", "Sequence", and "QualityScore". The output file has the same name as the input data frame. The function loops over the data frame and writes each read to the output file in the FASTQ format. It then closes the output file and removes the temporary file. Finally, it prints a message indicating the successful writing of the data frame to the FASTQ file.
</p>
<p align="justify">
The write.list_to_fasta function takes a list of sequences and writes them to a FASTA file. Each element in the list is a character string representing a single sequence. The function uses the name of the list as the base name for the output file with the .fasta extension. Each sequence is written to the output file in FASTA format with the sequence name as the header. The function loops over the list elements and writes each sequence to the file in FASTA format. The output file is closed and a message is printed indicating successful write.
</p>
<p align="justify">
The write.list_to_fastq function is a tool that writes a list of DNA sequences and their corresponding quality scores to a FASTQ file format. The function takes a list of sequences as input, where each element of the list is a named list containing "Sequence" and "QualityScore" elements. The output file name is set as the input list name with the .fastq extension. Each sequence in the list is written to the output file in FASTQ format, where the sequence name is used as the header and the quality scores are on the following line. The function then prints a message indicating successful write.
</p>
<p align="justify">
The gc_content_file function takes a multi-FASTA file as input, calculates the GC content for each sequence in the file, and writes the results to a new FASTA file. The function first reads in the input file, parses the sequence names and sequences, and then calculates the GC content for each sequence using a function that splits the sequence into individual nucleotides and counts the number of Gs and Cs. The GC content is then added to the sequence names, and the results are written to a new file with the name format "inputfilename_with_GC_content.fasta". 
</p>
<p align="justify">
The clean_DNA_file function in R reads a multi-FASTA file containing DNA sequences, removes any characters other than A, T, G, and C, and writes the cleaned sequences to a new multi-FASTA file. The name of the output file is generated by adding the suffix '_clean.fasta' to the input file name. The function returns a character string specifying the path to the output FASTA file. The function works by opening the input file, reading the sequences and headers, cleaning the sequences, and writing the cleaned sequences to the output file.
</p>
<p align="justify">
The clean_RNA_file function reads a multi-FASTA file containing RNA sequences, removes any characters other than A, U, G, and C, and writes the cleaned sequences to a new multi-FASTA file. The name of the output file is generated by adding the suffix '_clean.fasta' to the input file name. The function returns a character string specifying the path to the output FASTA file. The function works by opening the input file, reading the sequences and headers, cleaning the sequences, and writing the cleaned sequences to the output file.
</p>
<p align="justify">
The clean_DNA_sequence function is a simple bioinformatics utility that removes any characters other than A, C, G, and T from a given DNA sequence. The input is a DNA sequence as a character string, and the output is the cleaned DNA sequence as a character string with only A, C, G, and T characters. This function can be useful in data cleaning and preprocessing steps before downstream analysis, such as sequence alignment or variant calling. The function is exported and can be used by other functions or scripts that require cleaning of DNA sequences.
</p>
<p align="justify">
The clean_RNA_sequence function takes an RNA sequence as input and removes any characters other than A, C, G, and U. This function is useful for cleaning up RNA sequences before downstream analysis, such as sequence alignment or expression analysis. The function first converts the sequence to upper case, then removes any characters that are not A, C, G, or U using regular expressions. The cleaned sequence is then returned as output.
</p>


CRAN REPO for version 0.1.0 : [baseq: Basic Sequence Processing Tool for Biological Data](https://cran.r-project.org/package=baseq)

GitHub REPO for version 0.1.0 : [baseq: Basic Sequence Processing Tool for Biological Data](https://github.com/ambuvjyn/baseq)

Authors :
**Ambu Vijayan** _Young Professional, ICAR - Central Tuber Crops Research Institute_

**Dr. J. Sreekumar** _Principal Scientist, ICAR - Central Tuber Crops Research Institute_

Maintainer :
**Ambu Vijayan**


