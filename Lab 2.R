#TASK 1
#install.packages("ISLR")
library(ISLR)
data(Auto)
attach(Auto)
head(Auto)

# Initialize a scatter plot
new_Auto <- Auto[,1:8]
new_Auto
plot(new_Auto)
#b. mean and standard deviation of the variables using grouping functions.
# get the first 6 columns
new_Auto
#find mean and standard deviation using apply function
apply(new_Auto, 2, mean)
apply(new_Auto, 2, sd)

#c. Aggregate the car data by number of cylinders and year, returning means on each
x <- subset(new_Auto, select= cylinders) # data to work on
s <- subset(new_Auto, select= year) # from which group to work with
aggregate(x, s, mean)




#Task 2.
# Load the Credit dataset from the ISLR package
library(ISLR)
data(Credit)
attach(Credit)
head(Credit)
#b.  calculate the mean and standard deviation of Income for each ethnic group
x <- subset(Credit, select= Income) # data to work on
y <- subset(Credit, select= Ethnicity) # from which group to work with
aggregate(x, y, mean)
aggregate(x, y, sd)

# Compare the distribution of incomes using ggplot2 density plots. 

g <- ggplot(Credit, aes(Income))
g
# g + geom_density()
# g + geom_density(fill = "red")
g + geom_density(aes(fill=factor(Ethnicity)), alpha=.7)


#TASK 3
# Sort the Credit data by Balance in ascending order and then by Income in descending order.
# How old is the person with the highest income among those with the balance equal to 0?
# Bal_Asc <- sort(Credit$Balance, index.return=TRUE)
# Bal_Asc
# head(Credit[Bal_Asc$Balance,])

library(dplyr)
Bal_Asc <- arrange(Credit, Balance, desc(Income))
Bal_Asc
Inc_Asc <- arrange(Credit, Income)
Inc_Asc


rich <- function() {
  # Filter the dataset for rows where Balance is 0
  Balance_data <- subset(Credit, Balance == 0)
    # Find the row with the maximum income in the filtered data
  max_income <- Balance_data[which.max(Balance_data$Income), ]
    # Return the age of the person with the highest income and Balance == 0
  return(max_income_row$Age)
}
result <- rich()
print(result)

#TASK 4
#Add a new variable that will have the values "Old" if the person is older than 60 years, and "Young"
#otherwise.
#Calculate the mean values of each quantitative variable for young and old people using
#a grouping function.
Credit$Age_Group <- ifelse(Credit$Age > 60, "Old", "Young")
Credit
x <- subset(Credit, select= Income) # data to work on
y <- subset(Credit, select= Age_Group) # from which group to work with
aggregate(x, y, mean)









