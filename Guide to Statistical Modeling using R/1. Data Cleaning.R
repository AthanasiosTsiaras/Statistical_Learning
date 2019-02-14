setwd("~/Desktop/My_Applications/Guide to Statistical Modeling using R")

options(digits=4)

# Loading data
dat <- read.csv('./data/Salaries.csv', header = TRUE)

# Getting an overview of the data

dim(dat) # Size: Rows, Columns
str(dat) # column names, variable types
head(dat) # View first 6 rows of the data
tail(dat) # View the last 6 rows of the data

# Data Cleaning
dat$SALARY <- as.character(dat$SALARY)
dat$SALARY <- gsub("\\$","",dat$SALARY)
dat$SALARY <- as.numeric(dat$SALARY)

dat$BONUS <- as.character(dat$BONUS)
dat$BONUS <- ifelse(dat$BONUS=='Yes', 1, 0)
dat$BONUS <- as.integer(dat$BONUS)

dat$AGE <- as.character(dat$AGE)
dat$AGE <- gsub("\\years","",dat$AGE)
dat$AGE <- as.integer(dat$AGE)

dat$INTERNAT <- as.character(dat$INTERNAT)
dat$INTERNAT <- ifelse(dat$INTERNAT=='Yes', 1, 0)
dat$INTERNAT <- as.integer(dat$INTERNAT)

dat <- dat[,3:12]
names(dat) <- c("id", "Salary", "Experience", "Education", "Bonus", "Employment", "Assets", "Board", "Age", "International")

# Final check
dim(dat) # Size: Rows, Columns
str(dat) # column names, variable types
head(dat) # View first 6 rows of the data
tail(dat) # View the last 6 rows of the data

write.csv(dat, "./data/Clean_Salaries.csv")