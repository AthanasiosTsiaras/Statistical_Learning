library(shiny)
library(tidyverse)

shinyUI(fluidPage(
  sidebarLayout(
          sidebarPanel(
                  titlePanel("Next Word"),
                  textInput("text", label = h3("Input word or phrase")),
                  submitButton(text = "Predict", icon = NULL, width = NULL)),
          
                  mainPanel(
                          titlePanel('Prediction Output'),
                          h3('Predicted word(s)'),
                          textOutput('value')
                          
                  )
          
  )
  )
  )
  
