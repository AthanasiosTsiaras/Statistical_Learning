# Environment Setup
setwd("~/Desktop/final")
libraries <- c('tm', 'plyr', 'class')
lapply(libraries, require, character.only=TRUE)

options(stringsAsFactors = FALSE)

path <- '~/Desktop/final/en_US'

# Create a function to clean the text files
corpus <- Corpus(DirSource(directory = path))

clean_corpus <- tm_map(corpus, removePunctuation)
clean_corpus <- tm_map(clean_corpus, stripWhitespace)
clean_corpus <- tm_map(clean_corpus, tolower)
clean_corpus <- tm_map(clean_corpus, removeWords,
                       stopwords('english'))

tdmatrix <- TermDocumentMatrix(clean_corpus)
tdmatrix <- removeSparseTerms(tsmatrix, 0.7)

tdm <- list(Term_Document_Matrix = tdmatrix)



