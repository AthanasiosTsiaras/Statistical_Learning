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
#write.table(all_text$text, file = "~/Desktop/final/en_US/alltext.csv")
#====================================Analyzing by word===================================

# Basic line and word summaries

source_text <- all_text %>%
        unnest_tokens(word, text)

source_text$word <- tolower(source_text$word)

line_word_info <- as.data.frame(list(
        'Blogs' = c(
                        dim(source_text[source_text$source=='news',])[1],
                        dim(all_text[all_text$source=='news',])[1],
                        round(mean(nchar(as.character(blogs$text))))
                ),
        
        'News' = c(
                                dim(source_text[source_text$source=='blogs',])[1], 
                                dim(all_text[all_text$source=='blogs',])[1],
                                round(mean(nchar(as.character(news$text))))
                ),
        
        'Twitter' = c(
                                dim(source_text[source_text$source=='twitter',])[1],
                                dim(all_text[all_text$source=='twitter',])[1],
                                round(mean(nchar(as.character(twit$text))))
                )))

row.names(line_word_info) <- c('Number of words', 'Number of lines', 'Average line length')

numbers=c('1','2','3','4','5','6','7','8','9','10')

source_words <- source_text %>%
        count(source, word, sort=TRUE) %>%
        filter(!substring(word,1,1) %in% numbers==TRUE) %>%
        filter(!word %in% stop_words$word) %>%
        ungroup()

news_words <- arrange(source_words[source_words$source=='news',][1:20,], -n)
blogs_words <- arrange(source_words[source_words$source=='blogs',][1:20,], -n)
twit_words <- arrange(source_words[source_words$source=='twitter',][1:20,], -n)

g_news <- ggplot(news_words, aes(x = reorder(word, -n), y = n)) +
        labs(title='Most frequent words in News', x='Word', y='Frequency')+
        geom_bar(fill = "#0073C2FF", stat = "identity") +
        theme_light()

g_blogs <- ggplot(blogs_words, aes(x = reorder(word, -n), y = n)) +
        geom_bar(fill = "#0073C2FF", stat = "identity") +
        labs(title='Most frequent words in Blogs', x='Word', y='Frequency') +
        theme_light()

g_twit <- ggplot(twit_words, aes(x = reorder(word, -n), y = n)) +
        geom_bar(fill = "#0073C2FF", stat = "identity") +
        labs(title='Most frequent words in Twitter', x='Word', y='Frequency') +
        theme_light()


words_by_source <- as.data.frame(cbind('twitter'=twit_words[,2:3],
                                       'news'=news_words[,2:3], 
                                       'blogs'=blogs_words[,2:3]))

print(line_word_info)
print(words_by_source)
print(g_news)
print(g_blogs)
print(g_twit)
#==================================Tokenizing by n-gram=================================

# How frequently do 2 words appear together?

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
        filter(!substring(second_word,1,1) %in% numbers==TRUE) %>%
        filter(!first_word %in% stop_words$word) %>%
        filter(!second_word %in% stop_words$word)

bigram_united <- bigram_filt %>%
        unite(bigram, first_word, second_word, sep = " ")

bigram_counts <- bigram_united %>% count(bigram, sort=TRUE)

bigram_graph <- bigram_counts %>%
        separate(bigram, c("first_word", "second_word"), sep = " ") %>%
        filter(n > 2700) %>%
        graph_from_data_frame()

arr <- grid::arrow(type = "closed", 
                   length = unit(.2, "cm"))

set.seed(10-20-2018)

ggraph(bigram_graph, layout = "kk") +
        geom_edge_link(aes(edge_alpha = n), show.legend = FALSE,
                       arrow = arr, end_cap = circle(.1, 'cm')) +
        geom_node_point(color = "darkblue", size = .5) +
        geom_node_text(aes(label = name), vjust = 1, hjust = 1) +
        theme_void()

# How frequently do 3 words appear together?

trigram <- all_text %>% 
        unnest_tokens(trigram, text, token = "ngrams", n = 3) 

trigram_token <- trigram %>%
        filter(!is.na(trigram)) %>%
        separate(trigram, c("first_word", "second_word", "third_word"), sep = " ")

trigram$first_word <- tolower(trigram$first_word)
trigram$second_word <- tolower(trigram$second_word)
trigram$third_word <- tolower(trigram$third_word)

trigram_filt <- trigram %>%
        filter(!substring(first_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(second_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(third_word,1,1) %in% numbers==TRUE) %>%
        filter(!first_word %in% stop_words$word) %>%
        filter(!second_word %in% stop_words$word) %>%
        filter(!third_word %in% stop_words$word)

trigram_united <- trigram_filt %>%
        unite(trigram, first_word, second_word, third_word, sep = " ")

trigram_counts <- trigram_united %>% count(trigram, sort=TRUE)

print(trigram_counts)

# Quadgrams

quadgram <- all_text %>% 
        unnest_tokens(quadgram, text, token = "ngrams", n = 4) 

quadgram <- quadgram[complete.cases(quadgram),] %>%
        separate(quadgram, c("first_word", "second_word", "third_word", "fourth word"), sep = " ")

quadgram_filt <- quadgram %>%
        filter(!substring(first_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(second_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(third_word,1,1) %in% numbers==TRUE) %>%
        filter(!substring(fourth_word,1,1) %in% numbers==TRUE) %>%
        filter(!first_word %in% stop_words$word) %>%
        filter(!second_word %in% stop_words$word) %>%
        filter(!third_word %in% stop_words$word) %>%
        filter(!fourth_word %in% stop_words$word)

quadgram_united <- quadgram_filt %>%
        unite(quadgram, first_word, second_word, third_word, fourth_word, sep = " ")

quadgram_counts <- quadgram_united %>% count(quadgram, sort=TRUE)

print(quadgram_counts)