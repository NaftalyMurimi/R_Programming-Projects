# Task 1
# Load the following description of the Cognitive technologies field into RStudio. You can
# download in from the Platform.
# setwd("C:/Users/Weronika/Desktop/Weronika/Studia/Programming/R/Laby/Materiały do pracy")
CT <- readLines("lab4_task1.txt") #the best way
myway <- read.table("lab4_task1.txt", header=F, sep=" ", stringsAsFactors = FALSE)
length(text)
# sep="\n": Traktuje każdą linię tekstu jako osobny wiersz w tabeli.
# stringsAsFactors=FALSE: Zapobiega konwersji tekstu na faktory, co jest istotne
# w przypadku pracy z tekstem.

# a) Find the positions of the word “specialist” in the text above. How many times does
# it appear?
positions <- gregexpr("specialist", CT, ignore.case = TRUE)
length(positions[[1]]) #gregexpr always returns a SINGLE list. That is why index is [[1]].
# The amount of times it appears (funkcja length liczy liczbę elementów wektora, dlatego zwraca 4)

# b) Extract the first 100 signs and print them.
signs <- substr(CT, 1, 100)
print(signs)

# c) Find where the first sentence ends and extract it.
# Finding first occurence of the special sign ending the sentence:
sentence1 <- regexpr("\\.\\s", CT) # Funkcja regexpr szuka kropki, po której będzie spacjam oznaczająca
                                    # początek nowego zdania, pierwszej od lewej (szukamy pierwszego zdania)
sentence1 # First occurance on position 194

substr(CT, 1, 194) # prints the sentence

# d) Check how many digits \d there are in the text.
digits <- gregexpr("\\d", CT)
length(digits[[1]])

# e) Substitute "4-semester" with "four-semester".
sub("4-semester", "four-semester", CT, ignore.case=TRUE)

# f) Check how many sentences there are in the text.
# Hint: All sentences end with a dot. After each sentence (apart from the last one)
# there is a space.
sentences <- gregexpr("\\.\\s", CT)
length(sentences[[1]])+1 # dodaje ostatnie zdanie po którym nie ma spacji!
sentences

# g) Check how many words there are in the text.
wrongwords <- gregexpr("\\s+", CT)
length(words[[1]]) # ŹLE BO TO LICZY ILOŚĆ SPACJI A JA SZUKAM ILOŚCI SŁÓW
# Należy podzielić tekst na pojedyncze słowa:
words <- unlist(strsplit(CT, "\\s+")) # funkcja unlist zmienia liste w wektor
length(words)

# h) Check how many signs there are in the text.
nchar(CT)

# i) Check how many unique signs there are in the text.
split <- unlist(strsplit(CT, ""))
unique <- unique(split)
length(unique)

# j) Print 10 most and least frequent signs.
split # call up CT but already converted into a vector of words
table_split <- table(split) # zobacz podsumowanie za pomocą tabeli
# most frequent:
sorted1 = sort(table_split, decreasing=T) # posortuj utworzoną tabelę
head(sorted1, 10)
# least frequent:
sorted2 <- sort(table_split)
head(sorted2, 10)

# k) Translate the text to lowercase.
lowercase <- tolower(CT)

# l) Export the resulting text to a TXT file.
write.table(lowercase, "CT_lowercase.txt", append=TRUE, quote = F, row.names = F, col.names = F)

# Task 2
# Load the tweets.RData file into RStudio. It is a data frame containing the tweets published
# by the RDataMining profile in a certain time range
load("tweets.RData")
# a) What is the number of tweets?
nrow(tweets)

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
  scale = c(4, 0.5) # Dopasowanie skali i rozmiaru słów
)
cloud
                   