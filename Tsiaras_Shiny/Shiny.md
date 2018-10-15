Tsiaras Airquality Report
========================================================
author: Athanasios Tsiaras
date: Monday October 15, 2018
autosize: true

Ozone and Temperature in New York City 1973, by Month
========================================================


This application examines the correlation of wind and temperature. The use can select a specific month from May to September and a scatterplot of wind and temperature is displayed.

Airquality package
========================================================
This application uses the ‘airquality’ built-in R package. This package has atmospheric measures for the city of New York from May to September 1973. More info on airquality can be found on: https://www.rdocumentation.org/packages/datasets/versions/3.5.1/topics/airquality. 

R code: ui.R
========================================================

```r
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
```

<!--html_preserve--><div class="container-fluid">
<h2>Tsiaras' First Shiny App!</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<h3>Month</h3>
<div class="form-group shiny-input-container">
<label class="control-label" for="month">Insert Month</label>
<input class="js-range-slider" id="month" data-min="5" data-max="9" data-from="1" data-step="1" data-grid="true" data-grid-num="4" data-grid-snap="false" data-prettify-separator="," data-prettify-enabled="true" data-keyboard="true" data-data-type="number"/>
</div>
<div>
<button type="submit" class="btn btn-primary">Submit</button>
</div>
</form>
</div>
<div class="col-sm-8">
<h3>Map</h3>
<div id="plot1" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
</div>
</div>
</div><!--/html_preserve-->
R code: server.R
========================================================

```r
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
             
        })
        
       
})
```


