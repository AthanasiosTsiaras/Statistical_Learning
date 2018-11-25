library(shiny)
library(shinyjs) 
library(tesseract)
library(stringr)
library(dplyr)
# Create a shiny app that extracts text from images
ui <- fluidPage(
   
   
   # Sidebar with a text input for the image link
   sidebarLayout(
      sidebarPanel(
              h5("How to use the app:"),
              h5("1. Choose an image file from your computer (.jpeg, .png, .jpg)"),
              h5("2. Hit the 'Get Text from Image' button, after the file is uploaded"),
              h5("3. The text generated from the image will appear below the app title"),
              
              fileInput("file1", "Choose Image File",
                        accept = c(".jpg",".png",".jpeg")
              ),
              
              actionButton("scrapeText", "Get Text from Image")
              ),
        
      # Main panel that showcases the text scraped from the image
      mainPanel(
              h1("Thanos - Image to insights",align="center"), # App Title
              h6("This app was created by Athanasios K. Tsiaras and allows users to extract text from image files", align="center"),
              h6("Please follow the instructions on the right", align="center"),
              h6("Enjoy!", align="center"),
              div(htmlOutput("contents"), style = "text-align:center"),
              downloadButton("downloadData", "Download to .csv")
         
      )
   )
)


# Define server logic required to:
#       1. Let the user choose an image from their computer
#       2. Check if it's really an image
#       3. Scrape the text from the image
#       4. Pesent text summaries

server <- function(input, output) {
        
        # Creating a function that makes sure the user has uploaded an image file
        observeEvent(input$scrapeText, {
                image <- input$file1
                path <- image$datapath
                path <- str_split(path,"\\.")
                
                if (is.null(image))
                {
                        output$Error <- renderUI(
                                return("* Please Choose a File")
                        )
                }
                else if((path[[1]][-1] != "png") && (path[[1]][-1] != "jpg") && (path[[1]][-1] != "jpeg"))
                {
                        output$Error <- renderUI(
                                return("* Please Choose a .jpg/.jpeg/.png File")
                        )
                }
                else
                {
                        output$Error <- renderUI(
                                return("")
                        )
                        output$myImage <- renderImage({
                                image <- input$file1
                                path <- image$datapath
                                list(src = path,
                                     #contentType = c( 'jpg'),
                                     width = 400,
                                     height = 300)
                        }, deleteFile = FALSE)
                        
                        output$downloadData <- downloadHandler(
                                filename = function() {
                                        paste(input$dataset, ".csv", sep = "")
                                },
                                content = function(file) {
                                        write.csv(scraped$text, file, row.names = FALSE)
                                }
                        )
                        
                        output$Completed <- renderUI(
                                return("Scrapping Completed")
                        )
                        get_text(image)
                        
                        
                }
        })
        
        scraped <- reactiveValues(
                data = NULL,
                clear = FALSE
        )
        insights <- reactiveValues(
                data = NULL,
                clear = FALSE
        )
        
        get_text <- function(image){
                text <- tesseract::ocr(image$datapath, engine = tesseract("eng"))
                scraped$text=str_replace_all(text,"\n","<br>")
                # Leave it for now insights <- as.character(tesseract::ocr_data(image$datapath, engine = tesseract("eng")))
        }
        # User image showcase
        output$myImage <- renderImage({
                image <- input$file1
                path <- image$datapath
                list(src = path,
                     #contentType = c( 'jpg'),
                     width = 400,
                     height = 300)
        }, deleteFile = FALSE)
        # Instruct the algorithm to run the output only if the scraped file has non NA values
        if (!is.null(scraped)){
                output$contents <- renderUI({
                
                HTML(scraped$text)

       
                })
        }
}
# Run the application 
shinyApp(ui = ui, server = server)

