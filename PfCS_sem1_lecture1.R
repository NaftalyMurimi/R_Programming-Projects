# PROGRAMMING FOR COGNITIVE SCIENCES: Lecture 1
# Joanna Tobiasz, Anna Papiez

setwd('your_directory')
getwd()

# BASIC DATA TYPES --------------------------------------------------------


# Relation:             < > <= >= == !=
# Assignment:           = <- <<- -> ->>
# Special:              %in%


rm(list = ls())

i = 10L 
x = 40.0
s = 'abc'

print(i/4L)      # 2.5 - floating-point division
print(i %/% 4)	 # 2 - integer division
print(i/4.0)     # 2.5
print(c(i,x,s)) # 10 40 abc
print(paste0(s,'xyz'))  # abcxyz
print(paste0(rep(s,45))) # abcabc
print(is.integer(i)) # True
print(typeof(s)=='logical') # False
q = as.integer(3.7) # narrowing conversion
j = as.integer('123') # conversion
k = as.integer('123.55') # conversion


# LOGICAL OPERATORS -------------------------------------------------------


A <- c(TRUE, FALSE)
B <- c(TRUE, TRUE)
C <- c(FALSE, TRUE)

A & B # per-element logical operator

A && B # first-element logical operator
A && C # first-element logical operator

A | B # per-element logical operator



# VECTOR ------------------------------------------------------------------

# Type: vector
# - represents a 1-dimensional array
# - 1-based indexing
# - can store any type of data
# - all elements have to be of same (basic) type

V = c(9, 2, 3, 4)     # four-element numeric vector
V
typeof(V)
U = c(c(1,2),c(2,4))  # another four-element numeric vector
U
typeof(U)
X = c('abc', 'pqr', 'abracadabra')  # chr vector
X
typeof(X)
Y = c(123, TRUE, 'xyz')             # type conversion: chr vector
Y
typeof(Y)
XY = c(X, Y)                        # six element vector
XY

a = V[1]    # get an element
a
V[3] = 10   # set an element
V
V[10] = 15  # automatic extension (unknown values filled with NA)
V
is.na(V[5])
length(V)
length(V) = 100 # extension
V
X[length(X)] = 12 # set the last element
X
W = V[c(1,3)] # get a subvector (copy)
W
W[1] = 3.14   # does not modify V
W
Z = c(1L, 2L)     # integer vector
Z
Z[1] = 6.7        # type conversion: numeric
Z
Z[2] = 'qwerty'   # type conversion: chr
Z


# logical vector
I = (X == Y)
I
J = (X == Z)
J

# check if all/any elements are true
all(I)
all(J)
any(I)

I[1] = FALSE

all(I)
any(I)


# checking if element is in vector
rm(list = ls())
V = c(1, 2, 3)
2 %in% V 
c(3, 5) %in% V

# Naming elements
names(V) = c("A", "B", "C") # set names
print(V)
x = V["B"]                  # get named number
x
typeof(x)
y = V[["B"]]                # get unnamed number
y
typeof(y)



# MATRIX ------------------------------------------------------------------

# Type: matrix
# - extension of vector type,
# - can store any type of data,
# - all elements have to be of same type,
# - stored in a column-major order

rm( list = ls())

# initializing from data
A = matrix(data=c(1,2,3,4), nrow=2, ncol=2)                 # 2D 2x2 float array, elements initialized by columns
B = matrix(data=c(1L,2L,3L,4L), nrow=2, ncol=2, byrow=TRUE) # 2D 2x2 integer array, elements initialized by rows (always stored by columns)
print(A)
print(B)
print(B[2,2])
D = matrix(data=c(1,2), nrow=1, ncol=2)               # 2D 1x2 row vector
E = matrix(data=c(1,2), nrow=2, ncol=1)               # 2D 2x1 column vector
F = array(data=seq(1,8), dim = c(2,2,4))    # 3D 2x2x2 array
E = matrix(data=seq(1,8), dim = c(2,2,2))
print(F)


# special initialization
U = matrix(nrow=2, ncol=3)          # 2x3 NA array (float)
Z = matrix(data=0, nrow=2, ncol=3)  # 2x3 zeros array (float)
O = array(data=1, dim = c(1,2,3))   # 1x2x3 ones array (float)
I = diag(4)                         # 3x3 identity array (float)
typeof((I))
# random matrices
m = 5
n = 3
U = matrix(data=runif(m*n,100,200), nrow=m, ncol=n) # m-by-n array, uniform distribution [100,200]
matrix(data=runif(300,1,20), nrow=4, ncol=4)
N = matrix(data=rnorm(m*n,2,10), nrow=m, ncol=n)    # m-by-n array, normal distribution (2,10)

# Accessing elements
# - getting submatrix creates a copy

A = matrix(data=seq(1,6), nrow=3, ncol=2, byrow=TRUE)
a = A[1,1]    # get an element
A[1,2] = 8    # set an element
A[5,1] = 6    # no autoextension
A[,1] = 5     # set a column
rowA = A[-1,]  # get a row copy as 1D vector
rowA[1] = 55  # does not modify A

B = A         # create a copy
B[1,1] = 7    # does not modify A

A = matrix(data=seq(1,100), nrow = 10, ncol = 10, byrow = TRUE)
rowA = A[3,]              # get row copy
colA = A[,2]              # get column copy
subA = A[seq(10,1,-3),seq(1,10,2)]


# concatenation
A = matrix(data=c(1,2,3,4), nrow=2, ncol=2)                 # 2D 2x2 float array, elements initialized by columns
B = matrix(data=c(1L,2L,3L,4L), nrow=2, ncol=2, byrow=TRUE) # 2D 2x2 integer array, elements initialized by rows (always stored by columns)

vAB = rbind(A, B) # stack vertically
hAB = cbind(A, B) # stack horizontally

# reshape matrix
dim(hAB) = c(1,8)

# diagonals
A = matrix(data=seq(1,9), nrow = 3, ncol = 3)
D = diag(A) # dimensionality reduction: extract diagonal
X = diag(D) # dimensionality extension: build matrix from diagonal

diag(A) = 2 * D # set matrix diagonal



# LIST --------------------------------------------------------------------

# Type: list
# - like vector, but more flexible
# - every element can be of any type (array of pointers)

rm(list=ls())

A = list(1, 2, 3)         # list of three numerics
B = list(1, 'abc', TRUE, list(2,5))  # list of numeric, chr, logical, other list
subA = A[1]               # copy sublist of lengh 1
subB = B[1:2]             # copy sublist of length 2

a = A[[2]]                # get an element
A[[1]] = 100              # set an element

A[["xyz"]] = 4            # add an element with a string key
b = A[["xyz"]]            # get an element with a string key
c = A$xyz                 # alternative get syntax

A = c(A, 123)             # extend a list by an element
A = c(A, B)               # concatenate lists



# DATA FRAME --------------------------------------------------------------

# Type: data frame
# - 2-dimensional
# - can store any type of data,
# - all elements in the same column have to be of same type,
# - each coulumn can be of a different type.


rm(list=ls())

d <- data.frame(id = c(1, 2, 3, 4), 
                name = c("John", "Anne", "Tom", "Kate"), 
                status = c(TRUE, TRUE, FALSE, FALSE))
str(d)
colnames(d) <- c("ID", "Name","Status")
str(d)
rownames(d) <- c('Person1', 'Person2', 'Person3', 'Person4')

d$Name
d[,2]
d[2]


# USEFUL FUNCTIONS --------------------------------------------------------

## Vector -----------------------------------------------------------------

rm(list=ls())

my_vector <- seq(1, 20, by = 2)

print(my_vector)
length(my_vector)
summary(my_vector)

head(my_vector)
head(my_vector, 3)
my_vector[1:3]
my_vector[1:3] == head(my_vector, 3) # comparison
all(my_vector[1:3] == head(my_vector, 3))
any(my_vector[1:3] != head(my_vector, 3))
all(c(1, 4657, 5) == head(my_vector, 3))
any(c(1, 4657, 5) == head(my_vector, 3))

tail(my_vector)
tail(my_vector, 4)


## Data frame ---------------------------------------------------------------

rm(list=ls())

data("iris") # Iris data set

str(iris) # structure of the data frame

head(iris) # first 6 rows
head(iris, 10) # first 10 rows
tail(iris, 10) # last 10 rows

summary(iris)

dim(iris) # dimensions
nrow(iris) # number of rows
ncol(iris) # number of rows

iris$Sepal.Length == iris$Sepal.Width # are the values the same?
any(iris$Sepal.Length == iris$Sepal.Width) # is there at least one flower with equal sepal width and length?

unique(iris$Species) # unique values
table(iris$Species) # how many observations in each group?

duplicated(iris) # is row duplicated?
any(duplicated(iris)) # is any row duplicated?
which(duplicated(iris)) # which row is duplicated?

duplicated(iris$Petal.Length) # duplicated petal lengths
which(duplicated(iris$Petal.Length))

max(iris$Petal.Width) # maximal value of petal width
which.max(iris$Petal.Width) # which observation has a maximal value of petal width?
which(iris$Petal.Width == max(iris$Petal.Width)) # actually, there are more observations with this value!!!


# FUNCTIONS ---------------------------------------------------------------


# no explicit return value
# return the last statement
display <- function(x){
  print(x)
}

# explicit return
sqr = function(x){
  return(x*x)
}

# function that does nothing
doNothing <- function(x) {
  NULL
}


b = display('abc') # b is 'abc?
p = sqr(2) # p is 4

# default and named arguments
fun <- function(x, y=10, s='abc') {
  print(paste(x,y,s))
}

fun(0) 		            # fun(0, 10, 'abc')
fun(1, 3.14, 'xyz')
fun(2, s='PS')        # named argument - fun(2, 10, PS')
fun(y=4, x=1)	        # named arguments - fun(1, 4, 'abc') 
fun(5, x=1) 	        # strange order, but ok - fun(1, 5, 'abc')

fun2 = function(x=1, y) { # non-default may follow default
  x + y
} 
fun2(y=3)	# fun(1,3)


# PACKAGES ----------------------------------------------------------------

# install packages
install.packages("ggplot2")

# load package
library(ggplot2)



# IF CONTROL STRUCTURE ----------------------------------------------------

# Blocks defined by braces
id = 4
if (id > 0) {
  x = 1
  y = 1
} else if (id == 0) { 
  x = 2; y = 3 
} else if (id < 0) 
  x = 3 else {x = 4}



# LOOPS -------------------------------------------------------------------


# Iterate over collection
V = c('a','b','c') # vector def.
for (e in V) {
  print(e)
}

# Iterate over range (right included)
for (i in 0:9) {
  print(i)
}

# while loop
i = 10
while (i > 0) {
  print(i)
  i = i - 1
}

# 100, 95, ..., 5, 0
for (i in seq(100,0,-5)) { print(i) }

# reversed collection
for (e in rev(V)) { print(e) }

# break, next	
for (i in 0:99){ 
  if (i == 50) { 
    break # break the loop
  } 
  if (i %% 2 == 1) {
    next # next iteration	
  }
  print(i)
}


