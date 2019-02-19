
##### LOGISTIC REGRESSION #####

#--------------------------------------------------------------------------------------------------
# Loading the environment
#--------------------------------------------------------------------------------------------------

library(ISLR) # An Introduction to Statistical Learning with Applications in R, by Gareth James, Daniela Witten, Trevor Hastie and Robert Tibshiran
library(ggplot2) # plots
library(ggsci) # nice plots!
library(gridExtra) # plots arrangement

dat <- Default # This is the data we get from the book 'ISLR', which is available online for free. Big thanks to the authors for their great work.

# DATASET: This is a dataset of bank customers containing observations on their balance, income, whether they are students or not and if they
# ... defaulted on their loans. This script is building a logistic regression model to fit the observations.

dim(dat)
names(dat)
head(dat)
tail(dat)

#--------------------------------------------------------------------------------------------------
# Exploratory Analysis
#--------------------------------------------------------------------------------------------------

scat1 <- ggplot(dat, aes(x = balance, y = income, color = as.factor(default))) +
        geom_point() + 
        labs(x = "Balance", y = "Income", 
             title = "Balance vs Income by Default", 
             color = 'Default') +
        theme_bw() + 
        scale_color_aaas() +
        scale_fill_aaas()

box1bal <- ggplot(dat, aes(y = balance, x = default, color = as.factor(default))) +
        geom_boxplot() +
        labs(x = "Default", y = "Balance", 
             title = "Boxplot of Balance by Default", 
             color = 'Default') +
        theme_bw() + 
        scale_color_aaas() +
        scale_fill_aaas()
box1inc <- ggplot(dat, aes(y = income, x = default, color = as.factor(default))) +
        geom_boxplot() +
        labs(x = "Default", y = "Income", 
             title = "Boxplot of Income by Default", 
             color = 'Default') +
        theme_bw() + 
        scale_color_aaas() +
        scale_fill_aaas()
scat1
grid.arrange(box1bal, box1inc, ncol = 2)

#--------------------------------------------------------------------------------------------------
# Logistic Regression Model
#--------------------------------------------------------------------------------------------------

dat$default <- ifelse(dat$default=="Yes", 1, 0) # Converting to 0,1 from No,Yes
dat$student <- ifelse(dat$student=="Yes", 1, 0)

head(dat)

logplot1 <- ggplot(dat, aes(x=balance, y=default)) + 
        geom_point() + 
        stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE) +
        labs(x = "Balance", y = "P(Default)", title = "Logistic Regression plot of Balance") +
        theme_bw() + 
        scale_color_aaas() +
        scale_fill_aaas()

logplot2 <- ggplot(dat, aes(x=income, y=default)) + 
        geom_point() + 
        stat_smooth(method="glm", method.args=list(family="binomial"), se=FALSE) +
        labs(x = "Income", y = "P(Default)", title = "Logistic Regression plot of Income") +
        theme_bw() + 
        scale_color_aaas() +
        scale_fill_aaas()

grid.arrange(logplot1, logplot2, ncol = 2)

# The model

logmodel1 <- glm(default ~ . , data = dat, family = binomial())
summary(logmodel1)

# Indeed, income is not a significant predictor of default and it better be removed

logmodel2 <- update(logmodel1, . ~ . - income)
summary(logmodel2)

