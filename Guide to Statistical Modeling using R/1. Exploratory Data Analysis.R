setwd("~/Desktop/My_Applications/Guide to Statistical Modeling using R")

# Installing required libraries

library(ggplot2) # Visualization package - built according to Edward Tufte's guidelines
library(gridExtra) # Required to attach plots together

# Loading data
dat <- read.csv('./data/EXECSAL.csv', header = TRUE)

# Getting an overview of the data

dim(dat) # Size: Rows, Columns
str(dat) # column names, variable types
head(dat) # View first 6 rows of the data
tail(dat) # View the last 6 rows of the data

# Examining the distribution of the quantitative variables

hist1 <- ggplot(dat, aes(SALARY)) + 
        geom_histogram(bins = 15, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Salary") +
        labs(x = "Salary", y = "Frequency")

hist2 <- ggplot(dat, aes(EXP)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Experience") +
        labs(x = "Experience", y = "Frequency")

hist3 <- ggplot(dat, aes(EDU)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Education") +
        labs(x = "Education", y = "Frequency")

hist4 <- ggplot(dat, aes(EMPLOY)) + 
        geom_histogram(bins = 10, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Employment") +
        labs(x = "Employment", y = "Frequency")

hist5 <- ggplot(dat, aes(ASSETS)) + 
        geom_histogram(bins = 5, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Assets") +
        labs(x = "Assets", y = "Frequency")

hist6 <- ggplot(dat, aes(AGE)) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of Age") +
        labs(x = "Age", y = "Frequency")

grid.arrange(hist1, hist2, hist3, hist4, hist5, hist6, ncol = 3)

# Experience, Education and Employment variable transformation

hist22 <- ggplot(dat, aes(log(EXP))) + 
        geom_histogram(bins = 6, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Experience)") +
        labs(x = "Experience", y = "Frequency")

hist33 <- ggplot(dat, aes(log(EDU))) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Education)") +
        labs(x = "Education", y = "Frequency")

hist44 <- ggplot(dat, aes(log(EMPLOY))) + 
        geom_histogram(bins = 7, fill = "darkblue", col = "lightblue") + 
        ggtitle("Histogram of log(Employment)") +
        labs(x = "Employment", y = "Frequency")

grid.arrange(hist22, hist33, hist44, ncol = 3)

grid.arrange(hist1, hist22, hist33, hist44, hist5, hist6, ncol = 3)

# Outliers Detection

box1 <- ggplot(dat, aes(SALARY, group = 1)) + 
        geom_boxplot(aes(y=SALARY), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Salary")

box2 <- ggplot(dat, aes(EXP, group = 1)) + 
        geom_boxplot(aes(y=EXP), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Experience")

box3 <- ggplot(dat, aes(EDU, group = 1)) + 
        geom_boxplot(aes(y=EDU), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Education") 

box4 <- ggplot(dat, aes(EMPLOY, group = 1)) + 
        geom_boxplot(aes(y=EMPLOY), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Employment")

box5 <- ggplot(dat, aes(ASSETS, group = 1)) + 
        geom_boxplot(aes(y=ASSETS), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Assets")

box6 <- ggplot(dat, aes(AGE, group = 1)) + 
        geom_boxplot(aes(y=AGE), fill = "darkblue", col = "lightblue", outlier.colour = "purple") + 
        ggtitle("Boxplot of Age")

grid.arrange(box1, box2, box3, box4, box5, box6, ncol = 3)
