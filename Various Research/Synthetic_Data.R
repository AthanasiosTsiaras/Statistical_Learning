# The goal is to generate a synthetic dataset based on another one that contains sensitive information - therefore cannot be published
# With the new dataset, the structure of the original data is retained and any statistical inference derived from it is the exact same as of the original

# Importing libraries
suppressPackageStartupMessages(library(synthpop)) # Synthpop - R package for synthesizing population data
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(sampling))
suppressPackageStartupMessages(library(partykit))

mycols <- c("darkmagenta", "turquoise")
options(xtable.floating = FALSE)
options(xtable.timestamp = "")
myseed <- 20190110

# The DATASET -- SD2011
# The SD2011 contains 5000 observations and 35 variables on social characteristics of Poland. A subset of 12 of these variables are considered.
original.df <- SD2011 %>% dplyr::select(sex, age, socprof, income, marital, depress, sport, nofriend, smoke, nociga, alcabuse, bmi)
head(original.df)

# Since it is essential to retain the original structure of data, missing values should be generatedas there are in the original dataset
# and then dealth with accordingly
# Tip! -- Columns nofriend and nociga: -8 represents missing data, so we should specify that

# setting continuous variable NA list
cont.na.list <- list(income = c(NA, -8), nofriend = c(NA, -8), nociga = c(NA, -8))

# Before the synthesis we should process the data to ensure that values are consistent with reality - ex. married people are over 18 years old!

rules.list <- list(
        marital = "age < 18", 
        nociga = "smoke == 'NO'")

rules.value.list <- list(
        marital = "SINGLE", 
        nociga = -8)

# The variables in the condition need to be synthesised before applying the rule otherwise the function will throw an error. 
# In this case "age" should be synthesised before "marital" and "smoke" should be synthesised before "nociga."


SD2011[which.max(SD2011$bmi),] # There is one person with a bmi of 450

# getting around the error: synthesis needs to occur before the rules are applied
original.df$bmi <- ifelse(original.df$bmi > 75, NA, original.df$bmi) # If bmi is above 75, replace it with a NA

# apply rules to ensure consistency
rules.list <- list(
        marital = "age < 18", 
        nociga = "smoke == 'NO'")

rules.value.list <- list(
        marital = "SINGLE", 
        nociga = -8)


#-------------------Synthesise Data-------------------#
synth.obj <- syn(original.df, cont.na = cont.na.list, rules = rules.list, rvalues = rules.value.list, seed = myseed)


syn(data = original.df, rules = rules.list, rvalues = rules.value.list, 
                 cont.na = cont.na.list, seed = myseed)
#-------------------compare the synthetic and original data frames-------------------#
compare(synth.obj, original.df, nrow = 3, ncol = 4, cols = mycols)$plot



