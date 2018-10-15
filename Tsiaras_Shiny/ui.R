library(shiny)

shinyUI(fluidPage(
        titlePanel("Tsiaras' First Shiny App!"),
        sidebarLayout(
                sidebarPanel(
                        h3('Month'),
                        sliderInput('month', 'Insert Month', 5,9,1),
                        submitButton('Submit')
                        
                ),
                mainPanel(
                        h3('Map'),
                        plotOutput("plot1")
                )
                
                
        )
       
                
        )
)