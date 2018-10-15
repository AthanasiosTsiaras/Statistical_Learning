library(shiny)
library(plotly)
data(airquality)

shinyServer(function(input, output) {
        
        output$plot1 <- renderPlot({
                month<-input$month[1]
                data1 = airquality[airquality$Month==month,]
                xlab = 'Wind'
                ylab = 'Temperature'
                main=c('Ozone and wind on Month', month)
                plot(data1$Wind, data1$Temp, main=main, xlab=xlab, ylab=ylab)
                abline(lm(data1$Wind~data1$Temp))
                
        })
        
       
})
