# baseq
Basic Sequence Processing Tool for Biological Data

Commands are explained below

clean_sequence(): This function is a simple but useful utility function that removes any non-DNA characters from a DNA sequence, which can be helpful in preparing the input for downstream analyses.It takes a DNA sequence as input and returns a cleaned DNA sequence with only valid DNA characters (A, C, G, T). If there are any non-DNA characters present in the input sequence, they are removed.

count_bases(): The function is a simple but useful function that counts the occurrences of each nucleotide (A, C, G, and T) in a DNA sequence. The function takes a single argument sequence, which is a character string representing the DNA sequence, and returns a named integer vector indicating the count of each nucleotide.
The function is straightforward and easy to use, and it provides a quick way to get a summary of the nucleotide composition of a DNA sequence.

count_seq_pattern(): The function is a useful tool for counting the occurrence of a particular pattern within a sequence. The function takes two arguments: sequence which is the sequence to be searched, and pattern which is the pattern to be counted. The function returns the number of occurrences of the pattern in the sequence.

reverse_complement(): This function takes a DNA sequence as input and returns its reverse complement.

rna_reverse_complement(): This function takes an RNA sequence as input and returns its reverse complement.

dna_to_rna(): This function takes a DNA sequence as input and returns its RNA transcript. The code is very simple and straightforward, and the function name accurately describes what it does.

rna_to_dna(): This function takes an RNA sequence as input and returns its DNA complement. The code is very similar to dna_to_rna(), but with the additional step of converting U to T.

dna_to_protein(): The function takes a DNA sequence as input and returns the corresponding protein sequence using the standard genetic code.The function checks all six frames for potential protein coding sequences and outputs the translated protein sequences in a list with the frame number as a prefix.

rna_to_protein(): This function takes an RNA sequence as input and translates it in all six reading frames. 

gc_content(): The function takes a DNA sequence as input and calculates the percentage of G and C nucleotides in the sequence.

read_fasta(): This function reads in a file in the FASTA format and returns the sequences and sequence headers as a named list in R.

fastq_to_fasta(): This function converts a FASTQ file to a FASTA file by changing the extension and replacing the @ symbol with > for sequence headers.

read.fasta_to_df(): This function reads a fasta file into a dataframe and assigns it to the environment.

read.fasta_to_list(): This function reads a fasta file and assigns a list with the header and sequence information to the environment.

read.fastq_to_list(): This function reads a Fastq file and returns a list with three columns: Header, Sequence, and QualityScore.

write.df_to_fasta(): This function writes a data frame containing fasta records to a fasta file with the same name as the data frame.

write.df_to_fastq(): This function writes a FASTQ file from a dataframe of reads.

write.list_to_fasta(): This function takes a list of sequences and writes them to a FASTA file with each sequence as a header and its corresponding sequence.

write.list_to_fastq(): This function takes a list of sequences and quality scores and writes them to a FASTQ file with the name of the list as the base name.