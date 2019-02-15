setwd("~/Desktop/My_Applications/Guide to Statistical Modeling using R")

# Installing required libraries

library(ggplot2) # Visualization package - built according to Edward Tufte's guidelines
library(gridExtra) # Required to attach plots together

options(digits=4)

# Loading data
dat <- read.csv('./data/Clean_Salaries.csv', header = TRUE)

# Getting an overview of the data

dim(dat) # Size: Rows, Columns
str(dat) # column names, variable types
head(dat) # View first 6 rows of the data
tail(dat) # View the last 6 rows of the data

# Examining the distribution of the quantitative variables

hist1 <- ggplot(dat, aes(Salary)) + 
        geom_histogram(bins = 15, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Salary") +
        labs(x = "Salary", y = "Frequency")

hist2 <- ggplot(dat, aes(Experience)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Experience") +
        labs(x = "Experience", y = "Frequency")

hist3 <- ggplot(dat, aes(Education)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Education") +
        labs(x = "Education", y = "Frequency")

hist4 <- ggplot(dat, aes(Employment)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Employment") +
        labs(x = "Employment", y = "Frequency")

hist5 <- ggplot(dat, aes(Assets)) + 
        geom_histogram(bins = 5, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Assets") +
        labs(x = "Assets", y = "Frequency")

hist6 <- ggplot(dat, aes(Age)) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Age") +
        labs(x = "Age", y = "Frequency")

grid.arrange(hist1, hist2, hist3, hist4, hist5, hist6, ncol = 3)

# Experience, Education and Employment variable transformation

hist22 <- ggplot(dat, aes(log(Experience))) + 
        geom_histogram(bins = 6, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Experience)") +
        labs(x = "Experience", y = "Frequency")

hist33 <- ggplot(dat, aes(log(Education))) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Education)") +
        labs(x = "Education", y = "Frequency")

hist44 <- ggplot(dat, aes(log(Employment))) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Employment)") +
        labs(x = "Employment", y = "Frequency")

grid.arrange(hist22, hist33, hist44, ncol = 3)

grid.arrange(hist1, hist22, hist33, hist44, hist5, hist6, ncol = 3)

# Outliers Detection

box1 <- ggplot(dat, aes(Salary, group = 1)) + 
        geom_boxplot(aes(y=Salary), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Salary") +
        labs(x= "", y = "")

box2 <- ggplot(dat, aes(Experience, group = 1)) + 
        geom_boxplot(aes(y=Experience), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Experience") +
        labs(x= "", y = "")

box3 <- ggplot(dat, aes(Education, group = 1)) + 
        geom_boxplot(aes(y=Education), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Education") +
        labs(x= "", y = "")

box4 <- ggplot(dat, aes(Employment, group = 1)) + 
        geom_boxplot(aes(y=Employment), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Employment") +
        labs(x= "", y = "")

box5 <- ggplot(dat, aes(Assets, group = 1)) + 
        geom_boxplot(aes(y=Assets), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Assets") +
        labs(x= "", y = "")

box6 <- ggplot(dat, aes(Age, group = 1)) + 
        geom_boxplot(aes(y=Age), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Age") +
        labs(x= "", y = "")

grid.arrange(box1, box2, box3, box4, box5, box6, ncol = 3)

boxintern <- ggplot(dat, aes(group = International)) + 
        geom_boxplot(aes(y = Salary, x = International), fill = "darkblue", col = "lightblue", outlier.color = "purple") +
        ggtitle('Salary Distribution by International')


boxsalbonus <- ggplot(dat, aes(group = Bonus)) + 
        geom_boxplot(aes(y = Salary, x = Bonus), fill = "darkblue", col = "lightblue", outlier.color = "purple") +
        ggtitle('Salary Distribution by Bonus')


grid.arrange(boxintern, boxsalbonus, ncol = 2)



