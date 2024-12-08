#apply
#Purpose: Used for applying a function over the margins (rows or columns) of a matrix or an array.
mat <- matrix(1:9, nrow = 3)
mat
apply(mat, 1, sum)  # Sum of each row
apply(mat, 2, mean)  # Mean of each column

#sapply
#Purpose: A user-friendly version of lapply that simplifies the result into a vector or matrix (if possible).
list_data <- list(a = 1:5, b = 6:10)
list_data
typeof(list_data)
sapply(list_data, mean)  # Computes the mean of each list element


#lapply
# Purpose: Applies a function to each element of a list and returns the results as a list.
list_data <- list(a = 1:5, b = 6:10)
lapply(list_data, mean)  # Returns a list of means

# tapply
# Purpose: Used to apply a function over subsets of a vector, defined by factors or grouping variables.
data <- c(1, 2, 3, 4, 5, 6)
data
typeof(data)
groups <- factor(c("A", "A", "B", "B", "C", "C"))
groups
tapply(data, groups, sum)  # Sums values within each group

#by
#Purpose: A wrapper for tapply, used to apply a function to subsets of a data frame or matrix.
#Syntax: by(data, INDICES, FUN, ...)

data <- data.frame(values = c(1, 2, 3, 4, 5, 6),
                   groups = c("A", "A", "B", "B", "C", "C"))
data
by(data$values, data$groups, sum)  # Sums values within each group

#aggregate
#Purpose: Computes summary statistics of a data frame by applying a function to subsets of data grouped by one or more variables.

#Syntax: aggregate(x, by, FUN, ...)

# x: Data frame or a column vector.
# by: A list of grouping variables.
# FUN: Function to apply.

data <- data.frame(values = c(1, 2, 3, 4, 5, 6),
                   groups = c("A", "A", "B", "B", "C", "C"))
data
aggregate(values ~ groups, data, sum)  # Sums values by group





























