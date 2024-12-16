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
write.table(H, file = "MyText.txt", append = FALSE, quote = FALSE, sep = " ", eol = "\n")






# TASK 2
# load the tweets.RData file into RStudio. It is a data frame containing the tweets published 
# by the RDataMining profile in a certain time range. 
Mytweet <- readLines("tweets.RData")
Mytweet
head(Mytweet)     # Display the first few rows
str(Mytweet)      # View the structure of the data frame


# Text <- read.table("tweets.RData") 
# Text <- Text$V1
# a) What is the number of tweets? 
summary(Mytweet)
# Find the number of tweets (rows in the data frame)
num_tweets <- nrow(Mytweet)
print(Mytweet)

# b) Change "-" to “/” in the publication dates. 
# Assuming the publication dates are in a column named 'date' in the `tweets` data frame:
Mytweet$date <- gsub("-", "/", Mytweet$date)
# Check the updated data
head(Mytweet$date)

# c) Create a new column containing only the year of publication. 
# d) Create a violin plot of retweet counts per year. Mark years with different colours (parameter fill). 
# e) Check how many words there are in each tweet. Hint: if you have a list, in which 
# each element is a vector of words used in a tweet, you may use the lengths() function. 
# f) Count how many times each word appears in all tweets considered together. 
# g) Make a wordcloud plot with words that appeared at least 10 times. 







# Task 2
# Load the tweets.RData file into RStudio. It is a data frame containing the tweets published
# by the RDataMining profile in a certain time range
load("tweets.RData")
# a) What is the number of tweets?
nrow(tweets)
summary(tweets)

# b) Change "-" to “/” in the publication dates.
str(tweets)
tweets$created <- gsub("-", "/", tweets$created) # musi być na zmienna adresująca kolumne w df, żeby ją nadpisać
head(tweets)

# c) Create a new column containing only the year of publication.
tweets$year <- gsub("^(\\d{4}).*", "\\1", tweets$created)
head(tweets)
# ^: Asserts the start of the string.
# (\\d{4}): Captures the first four digits (the year, e.g., 2013) into a group.
# .*: Matches the rest of the string. The .* ensures you match all the remaining content of the string after the first four digits. 
# Without it, you wouldn’t consume the rest of the string during regex matching
# "\\1" - references the first captured group, in this case a year defined by (\\d{4})

# Create a violin plot of retweet counts per year. Mark years with different colours
# (parameter fill).
library(ggplot2)
violin_plot <- ggplot(tweets, aes(x = year, y = retweetCount, fill = year)) +
  geom_violin()

violin_plot

# e) Check how many words there are in each tweet. Hint: if you have a list, in which
# each element is a vector of words used in a tweet, you may use the lengths()
# function.
words <- unlist(strsplit(tweets$text, "\\s+"))
length(words) # However here I get how many words are in all tweets not in individual tweets
word_counts <- lengths(strsplit(tweets$text, "\\s+")) # correct approach
word_counts

# f) Count how many times each word appears in all tweets considered together.
# Dzielę wszystkie tweety na pojedyncze słowa: już to mam pod zmienną words z poprzedniego zadania
words
# text cleaning (optional, I guess, there should be more done, like removing URLs but don't know how to do that lol)
# to clear the text I can convert everything into lowercase and remove punctuation
words <- tolower(words)
words <- gsub("[[:punct:]]", "", words) # it says: remove punctuation and paste nothing in its place

freq_table <- sort(table(words), decreasing=T)
head(freq_table)
tail(freq_table)

# g) Make a wordcloud plot with words that appeared at least 10 times.
library(wordcloud)
my_table <- table(words)
sub_words <- subset(x = my_table, my_table >= 10)
# x - dane, których chcę użyć
# subset - subset konkretnie mniejszy lub równy 10
sub_words

# tworzenie chmury
cloud <- wordcloud(
  names(sub_words), # przekazuje słowa do chmury
  freq = sub_words, # przekazuje częstotliwość tych słów do chmury
  random.order = F, # zapewnia porządek malejący wg częstotliwości
  colors = brewer.pal(8, "Dark2"), # Dodanie kolorów z palety
  scale = c(1, 0.5) # Dopasowanie skali i rozmiaru słów
)
cloud







