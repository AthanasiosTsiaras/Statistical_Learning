### EXPLORATORY ANALYSIS

# Setting the datasets folder as the working directory

setwd("~/Desktop/final")

# Loading the necessary packages

library(dplyr)
library(tidytext)
library(stopwords)
library(stringi)
library(tidyr)
library(ggplot2)
library(igraph)
library(ggraph)
library(ggpubr)
library(gridExtra)
library(readr)

# Reading files into tibble frames

fileName <- c('en_US/en_US.news.txt', 'en_US/en_US.blogs.txt', 'en_US/en_US.twitter.txt')

news <- readLines(fileName[1])
news <- data_frame(source='news', line = 1:length(news),text=tolower(news))


blogs <- readLines(fileName[2])
blogs <- data_frame(source='blogs', line = 1:length(blogs),text=tolower(blogs))


twit <- readLines(fileName[3])
twit <- data_frame(source='twitter', line = 1:length(twit),text=tolower(twit))


all_text <- bind_rows(list(news,blogs,twit))
all_text$source <- as.factor(all_text$source)

all_text <- all_text[sample(nrow(all_text), 100000),]
numbers=c('1','2','3','4','5','6','7','8','9','10')
####
bigram <- all_text %>%
        unnest_tokens(bigram, text, token = "ngrams", n = 2)

# Most of the bigrams are common words useless for analysis ex. 'the', 'or', 'and', 'to
# We filter those out along with any possible NA values

bigram_token <- bigram %>%
        filter(!is.na(bigram)) %>%
        separate(bigram, c("first_word", "second_word"), sep = " ")

bigram_token$first_word <- tolower(bigram_token$first_word)
bigram_token$second_word <- tolower(bigram_token$second_word)

bigram_filt <- bigram_token %>%
        filter(!substring(first_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(second_word,1,1) %in% numbers==TRUE)

bigram_united <- bigram_filt %>%
        unite(bigram, first_word, second_word, sep = " ")

bigram_counts <- bigram_united %>% count(bigram, sort=TRUE)
bigram_counts <- bigram_counts %>%
        separate(bigram, c("first_word", "second_word"), sep = " ")
write_csv(bigram_counts, 'bigram.csv', append=FALSE, col_names = TRUE)
####
trigram <- all_text %>% 
        unnest_tokens(trigram, text, token = "ngrams", n = 3) 

trigram <- trigram %>%
        filter(!is.na(trigram)) %>%
        separate(trigram, c("first_word", "second_word", "third_word"), sep = " ")

trigram$first_word <- tolower(trigram$first_word)
trigram$second_word <- tolower(trigram$second_word)
trigram$third_word <- tolower(trigram$third_word)

trigram_filt <- trigram %>%
        filter(!substring(first_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(second_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(third_word,1,1) %in% numbers==TRUE)
        
trigram_united <- trigram_filt %>%
        unite(trigram, first_word, second_word, third_word, sep = " ")

trigram_counts <- trigram_united %>% count(trigram, sort=TRUE)
trigram_counts <- trigram_counts%>%
        separate(trigram, c("first_word", "second_word", "third_word"), sep = " ")
write_csv(trigram_counts, 'trigram.csv', append=FALSE, col_names=TRUE)

# Prediction function

next_word <- function(phrase){
        phrase <- tolower(phrase)
        phrase <- strsplit(phrase, split=' ')[[1]]
        length <- length(phrase)
        if (length ==1){
                big <- bigram_counts[bigram_counts$first_word==phrase[1],2]
                big <- big[!is.na(big),]
                if ( dim(big)[1]>3)  { return (big[1:3,][[1]]) } else { return(big[[1]]) }
        }else{
                big <- bigram_counts[bigram_counts$first_word==phrase[length],][1:3,2:3]
                big <- big[complete.cases(big),]
                names(big)[1] <- 'word'
                tri <- trigram_counts[(trigram_counts$first_word==phrase[length-1] & trigram_counts$second_word==phrase[length]),][1:3,3:4]
                names(tri)[1] <- 'word'
                
                result <- bind_rows(list(big,tri))
                result <- arrange(result,-n)[[1]]
                if (length(result)>3){
                        return(result[1:3])}
                else if(length(result)>0){
                        return(result[length])
                }else{
                        return('No prediction')
                }
                
        }
        
}
