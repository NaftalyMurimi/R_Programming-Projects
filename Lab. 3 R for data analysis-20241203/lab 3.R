# Download the fish dataset from the Educational Platform and load it. 

data <- "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lab. 3 R for data analysis-20241203/fish.csv"
loaded_data <- read.table(file = data, header = T, sep = ',')

# a) Check the class of the object in which the data are stored. 
class(data)
class(loaded_data)

# b) Investigate the structure of the dataset. 

str(loaded_data)

# c) Use the table function to check how many different fish you have in your data. Ans = 5

read.table(data, header = TRUE, sep = ",")
table(loaded_data$Species)
# Bream Parkki   Pike  Roach  Smelt 
# 35     11     17     20     14 

# d) Summarize all variables by calculating their basic statistics. 

summary(loaded_data)

# e) For each variable, check how many missing values there are in your data.
# 
# weight 4
# length1 2
# length2 1
# length 1
# length 3
# height 2
# width none
is_missing <- is.na(loaded_data)
head(is_missing)
table(is_missing) #total missing values are 11

apply(loaded_data, 2, function(i) {table(is.na(i))})

# f) Create a new data frame which will contain only rows without missing records.

complete_data <- complete.cases(loaded_data) 
complete_data

New_complete_data <- loaded_data[complete_data,] # removing rows with missing values
New_complete_data
any_missing <- is.na(New_complete_data)
head(any_missing)
apply(New_complete_data, 2, function(i) {table(is.na(i))}) #check if there are any missing data for all columns




# g) Export the new data frame you created to the text file. Use commas as field separators.

write.csv(New_complete_data, file = 'New_complete_data.csv')




# TASK 2
# Download the Heart dataset from the Educational Platform and load the data (you may use 
# the read.csv function suitable for comma-separated files). 
heart = "C:/Users/nafmu/Desktop/Cognitive Tech/R/Lab. 3 R for data analysis-20241203/Heart.csv"
my_heart <- read.table(file = heart, header = T, sep = ',')


# a) Using t-tests, check whether there are statistically significant differences in: 
#   • Cholesterol levels (Chol) in different Fasting Blood Sugar groups (Fbs: 0 - normal, 1 elevated); 
# t-test
chol_levels <- t.test(Chol~Fbs, data=my_heart)

chol_levels$statistic
chol_levels$p.value

# > chol_levels$statistic
# t 
# -0.1727894 
# > chol_levels$p.value
# [1] 0.8633893

# • Maximum Heart Rates (MaxHR) in people with and without Heart Disease (AHD);
HeartR_Dis <- t.test(MaxHR~Fbs, data=my_heart)
HeartR_Dis$statistic
HeartR_Dis$p.value

# > Heart_RATE$statistic
# t 
# 0.1397088 
# > Heart_RATE$p.value
# [1] 0.8893455

# • Resting Blood Pressure (RestBP) depending on Sex (0 - female, 1 – male).
BP_Sex <- t.test(RestBP~Sex, data=my_heart)
BP_Sex$statistic
BP_Sex$p.value

# > BP_Sex$statistic
# t 
# 1.062227 
# > BP_Sex$p.value
# [1] 0.2896814

# b) Verify the results of the t-tests with boxplots.
boxplot(Chol~Fbs, data=my_heart) 
boxplot(MaxHR~Fbs, data=my_heart) 
boxplot(RestBP~Sex, data=my_heart) 

# c) Using Fisher tests, check if there is a statistically significant dependency between: 
#   • Sex (0 - female, 1 – male) and people with and without Heart Disease (AHD); 
#create table with sex and heart disease only
sex_adh_table = table(my_heart$Sex, my_heart$AHD)
Sex_AHD <- fisher.test(sex_adh_table) 
Sex_AHD$p.value 
Sex_AHD$estimate

# • Sex (0 - female, 1 – male) and Chest Pain type (ChestPain).
sex_Cpain_table = table(my_heart$Sex, my_heart$ChestPain)
sex_Cpain <- fisher.test(sex_Cpain_table) 
sex_Cpain$p.value 
sex_Cpain$estimate


#TASK 3
# a) Create a plot with probability density function for the standard normal distribution for x 
# from -4 to 4. 
x <- seq(-4,4,0.01)
f <- dnorm(x) # probability density function

plot(x,f,pch=19)
# b) Draw 1000 random values from the standard normal distribution. 
# c) Add the histogram with data generated in point b) to the plot from point a). 
# d) Draw another 1000 random values from the normal distribution with a mean of 1 and 
# a standard deviation of 2. 
# e) Present the data generated in points b) and d) at two separate histograms with the same 
# ranges at both axes. What difference can you see?
  

















