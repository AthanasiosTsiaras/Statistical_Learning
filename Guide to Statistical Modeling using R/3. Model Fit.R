setwd("~/Desktop/My_Applications/Guide to Statistical Modeling using R")

# Installing required libraries

library(ggplot2) # Visualization package - built according to Edward Tufte's guidelines
library(gridExtra) # Required to attach plots together

options(digits=4)

# Loading data
dat <- read.csv('./data/Clean_Salaries.csv', header = TRUE)
dat <- dat[,-c(1,2)]

#####----------- Regression Analysis -----------#####

# Correlation (picking quantitative variables only)

QuantVar <- dat[, c('Salary', 'Experience', 'Education', 'Employment', 'Assets', 'Age')]

cormatr1 <- round(cor(QuantVar),3)
cormatr1[upper.tri(cormatr1)]<-""
cormatr1<-as.data.frame(cormatr1)
cormatr1

library(corrplot) # For a more visually appealing correlation matrix

corrplot(cor(QuantVar), type = "upper", method = "circle", tl.cex = 0.9)

# It would be a good idea to examine the correlation between Experience~Age, Salary~Age, Salary~Experience
# Either the two latter are great predictors, or just mean the same thing (which seems unlikely)
# The correlation between Experience and Age shows that probably one of them should be excluded
# If you think about it, it makes sense older people to have more experience! No information gain from including both

# Linear Regression

model1 <- lm(Salary ~ . , data = dat)
summary(model1)
# Very high p-values for Board, Age and International
# Updating the model 

model2 <- update(model1, . ~ . - Board - Age - International)
summary(model2)

# The coefficients are significant and the R-squared is more than 90% - The model fits the data pretty well

par(mfrow = c(2,2)) # Screen split to fit all-four plots
plot(model2)

# However, the residuals show some pattern and the qqplot is not clearly linear
# We should be careful about choosing a linear model for this one - Not saying that it's the wrong thing to do


#####----------- Regression Tree -----------#####

library(rpart)
library(rpart.plot)

par(mfrow = c(1,1)) # Reverse screen split

tree1 <- rpart(Salary ~ . , data = dat)
rpart.plot(tree1, type = 5, shadow.col = 'grey', main = 'Salary Regression Tree')

# Comparing the coefficients included in the tree and the linear model can give a more robust explanation about the significance of parameters
# Generally, if the linear model is a good fit it's always a good idea to choose it rather than the tree!

