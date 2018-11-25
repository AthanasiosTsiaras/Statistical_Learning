library(shiny)
library(tidyverse)

shinyUI(fluidPage(
  sidebarLayout(
          
          sidebarPanel(
                  
                  titlePanel("Next Word"),
                  textInput("text", label = h3("Input word or phrase")),
                  submitButton(text = "Predict", icon = NULL, width = NULL)),
                        
                  mainPanel(
                          img(src="swift.jpg", height = 143, width = 385),
                          titlePanel('Prediction Output'),
                          h3('Predicted word(s)')
                          
                  )
                  
  )
  )
  )
  
