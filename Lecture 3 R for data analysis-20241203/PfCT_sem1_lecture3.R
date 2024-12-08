# PROGRAMMING FOR COGNITIVE SCIENCES: Lecture 3
# Joanna Tobiasz, Anna Papiez

rm(list = ls()) # cleaning the workspace


# Data import ---------------------------------------------------------------

## From Excel sheet ==========================================================
install.packages("openxlsx")  # Install the package
library(openxlsx)             # Load the package
library(openxlsx)

myiris <- read.xlsx(xlsxFile = "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lecture 3 R for data analysis-20241203/iris2_dataset.xlsx")
str(myiris)
head(myiris)
    
myiris_cols <- read.xlsx(xlsxFile = "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lecture 3 R for data analysis-20241203/iris2_dataset.xlsx", colNames = F) # wrong way: no column names
str(myiris_cols)
head(myiris_cols)

myiris_row <- read.xlsx(xlsxFile = "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lecture 3 R for data analysis-20241203/iris2_dataset.xlsx", rowNames = T) # wrong way: first values as row names

myiris3 <- read.xlsx(xlsxFile = "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lecture 3 R for data analysis-20241203/iris2_dataset.xlsx", startRow = 3, colNames = F) # starting from the 3rd row
str(myiris3)
head(myiris3)


## From CSV/text file ==========================================================
a= 
nci <- read.csv(file = "NCI.csv", header = T)
str(nci)

nci2 <- read.table(file = "NCI.csv", header = T) # wrong way: we need to set comma as the separator
str(nci2)
colnames(nci2)

nci3 <- read.table(file = "NCI.csv", header = T, sep = ',')
str(nci3)

identical(nci, nci3) # are they identical?


# Missing values ----------------------------------------------------------

rm(list = ls()) # cleaning the workspace


myiris <- read.xlsx(xlsxFile = "iris2_dataset.xlsx")
str(myiris)
head(myiris)

table(myiris$Species) # how many flowers of different species?

summary(myiris)


is_missing <- is.na(myiris$Sepal.Length)
head(is_missing)
table(is_missing) # how many missing and complete records?


is_complete <- complete.cases(myiris$Sepal.Length)
head(is_complete)
table(is_complete) # how many missing and complete records?


any(is_missing) # is any record missing?
all(is_missing) # are all records missing?
any(is_complete) # is at least one record complete?
all(is_complete) # are all records complete?

apply(myiris, 2, function(i) {table(is.na(i))})


is_row_complete <- complete.cases(myiris) 
head(is_row_complete, 10)
head(is_complete, 10)

myiris_complete <- myiris[is_row_complete,] # removing rows with missing values


# Data export -------------------------------------------------------------

## To Excel sheet ===========================================================

write.xlsx(myiris_complete, file = 'myiris_complete.xlsx')


## To text file ==============================================================

write.table(myiris_complete, file = 'myiris_complete_tab.txt', sep = '\t')
write.table(myiris_complete, file = 'myiris_complete_tab.txt', sep = '\t', row.names = F)
write.table(myiris_complete, file = 'myiris_complete_tab.txt', sep = '\t', row.names = F, quote = F)

write.table(myiris_complete, file = 'myiris_complete_coma.txt', sep = ',', row.names = F, quote = F)
write.csv(myiris_complete, file = 'myiris_complete.csv')



# Statistical analysis ----------------------------------------------------


## Probability distributions ===============================================

x <- seq(-3,3,0.01)
f <- dnorm(x) # probability density function

plot(x,f,pch=19)

# Illustration of cumulative distribution function
segments(x0 = seq(-3,-1.64,0.001), y0=0, 
         x1=,seq(-3,-1.64,0.001), y1=dnorm(seq(-3,-1.64,0.001)),
         col="red",lwd=4)

pnorm(-1.64) # cumulative distribution function
qnorm(0.05) # inverse cumulative distribution function

pts <- rnorm(10000) # random generator from standard normal distribution
hist(pts,50,add=T,col=rgb(0,0,1, alpha=0.5), freq = F)


## Statistical testing ====================================================
library(ISLR)
data(Auto)
attach(Auto)

sAuto <- subset(Auto, cylinders >=6)

# t-test
tt <- t.test(horsepower~cylinders, data=sAuto)

tt$statistic
tt$p.value # There is a significant difference in horsepower between cars with 6 and 8 cylinders

boxplot(horsepower~cylinders,data=sAuto) 

# Fisher's test

# Contingency table
teaTesting <- matrix(c(3,1,1,3), nrow = 2, 
                     dimnames = list(Guess=c("Milk","Tea"),Truth=c("Milk","Tea")))

ft <- fisher.test(teaTesting) 
ft$p.value # The lady doesn't know her tea
ft$estimate


# Parallelization ---------------------------------------------------------

library(doParallel)

x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000

# Parallel
cl <- makeCluster(2)
registerDoParallel(cl)
ptime <- system.time({
  r <- foreach(icount(trials), .combine = cbind) %dopar% {
    ind <- sample(100,100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family = binomial(logit))
    coefficients(result1)
  }
})
stopCluster(cl)
ptime[3]

# Sequential
cl <- makeCluster(2)
registerDoParallel(cl)
stime <- system.time({
  r <- foreach(icount(trials), .combine = cbind) %do% {
    ind <- sample(100,100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family = binomial(logit))
    coefficients(result1)
  }
})
stopCluster(cl)
stime[3]

