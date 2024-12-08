#TASK 1
string = "hello"
real = 10
integer = 20L
is.numeric(string)
as.numeric(string)
is.integer(string)
as.integer(string)
is.character(string)
as.character(string)
typeof(string)
class(string)

is.numeric(real)
as.numeric(real)
is.integer(real)
as.integer(real)
is.character(real)
as.character(real)
typeof(real)
class(real)

is.numeric(integer)
as.numeric(integer)
is.integer(integer)
as.integer(integer)
is.character(integer)
as.character(integer)
typeof(integer)
class(integer)

# TASK 2
x= 22
# (a)
y = 2*sqrt(x+3)
y
# (b)
y = 1/ (x**2+x+6)
y
# (c)
y = 3-abs(x)
y

# TASK 3
 #(a)
ratio = function(a,b){
  return (a/b)
}
# (b)
ratio(35,10)
ratio(40,0)
# (c)
ratio1 = function(a,b){
  if(b==0){
    print("No division by zero")
  }
  else{
    print(a/b)
  }
}
ratio1(30,0)

# TASK 4
for(a in seq(0,50, 5)){
  if(a%%2==0){
    next
  }
  print(a)
}

#TASK 5
a <- c(0, 3,6,22,5,4)
for(i in a){
  if(i == 0){
    next
  }
  else{
    print(i*10)
  }
}

# TASK 6
install.packages("ISLR")
library(ISLR)
# a. search AUTO on the help section
Auto
head(Auto)
# b. Dimensions
dim(Auto) # 392 rows 9 columns
nrow(Auto)
ncol(Auto)
# c. names of  columns
colnames(Auto)
#d. structure of the data set
# Qualitative Data: Use when exploring characteristics, behaviors, or perceptions.
# Quantitative Data: Use when you need precise measurements or numerical analysis.
str(Auto)
# Quantitative Data: weight, horsepower, displacement, cylinders,year, mpg
# Qualitative Data: name, origin,  

# e. summary of all variables
summary(Auto)

#f. 

# g. Extract the quantitative variables and store them as new data frame.
new_df = Auto[1:6]
new_df
# h. In a loop, calculate the mean and standard deviation of each quantitative variable. 
# Print the results in each iteration. 
sapply(new_df, mean)
sapply(new_df, sd)

for (col_name in colnames(new_df)) {
  # Calculate mean and standard deviation
  col_mean <- mean(new_df[[col_name]])
  col_sd <- sd(new_df[[col_name]])
  
  # Print the results
  # Use cat() to format and print the output.
  cat("Column:", col_name, "\n")
  cat("Mean:", col_mean, "\n")
  cat("Standard Deviation:", col_sd, "\n\n")
}

# i. Write the function which returns the range of an input vector. 
# Function to calculate the range of a vector
#Range=Maximum_Value ??? Minimum_Value
calculate_range <- function(x) {
  if (!is.numeric(x)) {
    stop("Input must be a numeric vector")
  }
  # na.rm argument is used in functions to specify whether missing values (NA) should be removed before performing a calculation.
  range_value <- max(x, na.rm = TRUE) - min(x, na.rm = TRUE)
  return(range_value)
}
# Example vector
vec <- c(3, 7, 2, 9, 4)
range_value <- calculate_range(vec)
print(range_value)  # Output: 7

# Apply the function to each quantitative variable
for (col_name in colnames(new_df)) {
  # Check if the column is numeric
  if (is.numeric(new_df[[col_name]])) {
    range_value <- calculate_range(new_df[[col_name]])
    cat("Range of", col_name, ":", range_value, "\n")
  }
}

#  remove the 10th through 85th observations. What is the range, mean, and standard
#  deviation of each variable in the subset of the data that remains?
df_dropped <- new_df[-c(10:85), ]
df_dropped

for (col_name in colnames(df_dropped)) {
  # Calculate mean and standard deviation
  col_mean <- mean(df_dropped[[col_name]])
  col_sd <- sd(df_dropped[[col_name]])
  
  # Print the results
  # Use cat() to format and print the output.
  cat("Column:", col_name, "\n")
  cat("Mean:", col_mean, "\n")
  cat("Standard Deviation:", col_sd, "\n\n")
}


#TASK 7
# Install ISLR package if not already installed
install.packages("ISLR")
# Load ISLR package
library(ISLR)
# Load the Credit dataset
data("Credit", package = "ISLR")
# Display the first few rows of the dataset
Credit
# a) Use the help section to find out about the variables in this dataset.
# b) Investigate the structure of the dataset with the str() function. Which of the variables
# are quantitative, and which are qualitative?
str(Credit)
# quantitative <- income, limit, rating, cards, Age, balance
# qualitative <- ID, Education, Gender, Student, married, ethnicity

# c) Write a function that takes a vector as an input and returns "identical" if all elements are
# identical to the names of rows of the Credit data frame, and "different" otherwise.

# Function to check if a vector matches row names of the Credit dataframe
check_row_names <- function(input_vector) {
  # Get the row names of the Credit dataframe
  credit_row_names <- rownames(Credit)
  
  # Check if all elements in the input vector match the row names
  if (all(input_vector == credit_row_names)) {
    return("identical")
  } else {
    return("different")
  }
}

# d) With the use of a loop, apply your function to each column in Credit data frame.
# Loop to check each row against row names
# for (i in 1:nrow(Credit)) {
#   # Create a vector containing the row name of the current row
#   current_row_name <- rownames(Credit)[i]
#   # Call the function with a single-row name vector
#   result <- check_row_names(current_row_name)
#   # Print the result
#   cat("Row", i, ":", result, "\n")
# }
# Apply the function to each column
for (col_name in names(Credit)) {
  column <- Credit[[col_name]]
  result <- check_row_names(column)
  cat("Column:", col_name, "-", result, "\n")
}

str(Credit)
# e) Change the type of the first column into a character vector.
# Convert the first column to a character vector
Credit[, 1] <- as.character(Credit[, 1])
str(Credit)
# f) Repeat point (c).
# Re-run the function for the modified dataframe
for (col_name in names(Credit)) {
  column <- Credit[[col_name]]
  result <- check_row_names(column)
  cat("Column:", col_name, "-", result, "\n")
}

# g) Remove the column containing entries identical to the names of the rows.
# Identify and remove the column
columns_to_remove <- sapply(Credit, function(col) check_row_names(col) == "identical")
Credit <- Credit[, !columns_to_remove]

# Verify the result
str(Credit)
















