# PROGRAMMING FOR COGNITIVE SCIENCES: Lecture 4
# Joanna Tobiasz, Anna Papiez

rm(list = ls()) # cleaning the workspace


# Simple string analysis --------------------------------------------------

library("seqinr")

sars <- read.fasta(file = 'sarscov2.fasta')

length(sars[[1]])

table(sars[[1]])

head(sars[[1]])
tail(sars[[1]])


count(sars[[1]], 2)
count(sars[[1]], 3)


# Regular expressions -------------------------------------------------------------

load("genbank.RData") # loading the data

head(genbank, 20)

gb <- paste(genbank, collapse = "\n")
accPos <- regexec("ACCESSION\\s+(\\S{6})", gb) # "ACCESSION", one or more white spaces, and 6 non-white spaces
accession <- regmatches(gb, accPos)
accession

defPos <- regexec("DEFINITION\\s+((\\S| )+\\.)", gb) # "DEFINITION", one or more white spaces, one or more non-white spaces or space, a dot.
definition <- regmatches(gb, defPos)
definition

defPos <- regexec("ORGANISM\\s+((\\S| )+)", gb) # "ORGANISM", one or more white spaces, one or more non-white spaces or space.
organism <- regmatches(gb, defPos)
organism

medPos <- gregexpr("MEDLINE\\s+\\d+", gb) # "MEDLINE", one or more white spaces, one or more non-white digits.
medline <- regmatches(gb, medPos)
medline

seqPos <- gregexpr("ORIGIN.+$",gb)  # "ORIGIN", one or more any characters, end of a line.
sequence <- regmatches(gb, seqPos)
sequence
seqPos <- gregexpr("\\d+(c|t|g|a| )+\n", sequence[[1]]) # one or more any digits, one or more characters (c, t, g, a, or a space), new line.
sequence <- regmatches(sequence[[1]], seqPos)
sequence
seqPos <- gregexpr("( |a|t|c|g)+", sequence[[1]]) # one or more characters (a space, a, t, c, g).
sequence <- regmatches(sequence[[1]], seqPos)
sequence # a list without numbers

sequence <- paste(unlist(sequence), collapse = "")
sequence
sequence <- gsub(" ", "", sequence)
sequence
chartr("atcg", "tagc", sequence)
