rm(list = ls()) # cleaning the workspace
getwd()
setwd("C:/Users/nafmu/Desktop/Cognitive Tech/R/Lab. 4 Text-mining-20241210")
# TASK 1
Text <- read.table("lab4_task1.txt", sep="\n") 
Text <- Text$V1
Mytext <- readLines("lab4_task1.txt")
Mytext

# a) Find the positions of the word “specialist” in the text above. How many times does it appear? 
# grep("specialist",Mytext)
# regexpr("specialist", Mytext)
# regexec("specialist",Mytext)
gregexpr("specialist",Mytext)

# b) Extract the first 100 signs and print them. 
substr(Mytext, 1, 100)
# c) Find where the first sentence ends and extract it.
b<- regexpr("\\.\\s",Mytext)
regmatches(Mytext,b)

# d) Check how many digits there are in the text.
gregexpr("[0-9]",Mytext)

# e) Substitute "4-semester" with "four-semester".
sub("4-semester", "four-semester", Mytext)
# f) Check how many sentences there are in the text. 
# Hint: All sentences end with a dot. After each sentence (apart from the last one) there is a space. 
gregexpr("\\.\\s",Mytext)

# g) Check how many words there are in the text. 
strsplit(Mytext," ")
# h) Check how many signs there are in the text. 
nchar(Mytext)
p<- strsplit(Mytext,"")
p
q<-unlist(p)
length(q)
class(p)
length(p[[1]])
# i) Check how many unique signs there are in the text. 
unique(p)
# j) Print 10 most and least frequent signs. 

# k) Translate the text to lowercase. 
H<-tolower(Mytext)
H
# l) Export the resulting text to a TXT file. 









# TASK 2
