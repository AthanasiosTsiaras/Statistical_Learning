bigram_counts <- read_csv('bigram.csv')
trigram_counts <- read_csv('trigram.csv')

next_word <- function(phrase){
        phrase <- tolower(phrase)
        phrase <- strsplit(phrase, split=' ')[[1]]
        length <- length(phrase)
        if (length == 1){
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
shinyServer(function(input, output){
               output$value <- renderPrint(next_word(input$text))
})
        
      

