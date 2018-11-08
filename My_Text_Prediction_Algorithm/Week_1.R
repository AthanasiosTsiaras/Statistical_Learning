# Setting the datasets folder as the working directory
setwd("~/Desktop/final")

# Downloading the necessary packages
library(dplyr)
library(tidytext)
library(stopwords)
library(stringi)

# Reading files into tibble frames

fileName <- c('en_US/en_US.news.txt', 'en_US/en_US.blogs.txt', 'en_US/en_US.twitter.txt')

news <- readLines(fileName[1])
news <- data_frame(line = 1:length(news),text=news)

blogs <- readLines(fileName[2])
blogs <- data_frame(line = 1:length(blogs),text=blogs)

twit <- readLines(fileName[3])
twit <- data_frame(line = 1:length(twit),text=twit)


# Quiz 1.1 File Size
file.size(fileName[1])
file.size(fileName[2])
file.size(fileName[3])

# Quiz 1.2 Calculating the number of lines

print(dim(news)[1])
print(dim(blogs)[1])
print(dim(twit)[1])

# Quiz 1.3 Longest line per document
# 4mil

# Quiz 1.4 Calculating in how many lines the word 'love' occured. Same for the word 'hate'.

love <- dim(twit[grepl('love', twit$text),])[1]
hate <- dim(twit[grepl('hate', twit$text),])[1]
print(love / hate)

# Quiz 1.5 What does the one tweet that matches the 'biostats' word say?
twit[grepl('biostats', twit$text),]

# Quiz 1.6 Calculating how many times a phrase appears
# Phrase: "A computer once beat me at chess, but it was no match for me at kickboxing"

dim(twit[grepl("A computer once beat me at chess, but it was no match for me at kickboxing",
           twit$text),])[1] 
