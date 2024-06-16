# Alex Pinch, June 15 2024

library(shiny)
library(shinyWidgets)

birds <- read.csv("/Users/alexpinch/GitHub/private/phyl_bird/birds.csv", header = TRUE)
num_rows <- nrow(birds)

# selecting the answer
random_row <- sample(1:num_rows, 1)
answer <- birds[random_row, 1]

ui <- fluidPage(
  titlePanel("phyl_bird!!"),
  p("Text w rules about the game to go here"),
  
  # drop down menu
  # change this so that the drop-down only appears once you start typing (so that all possible birds aren't shown immediately)
  sidebarPanel(
      pickerInput(
        inputId = "bird_search", 
        label = "Search for a bird:", 
        choices = birds$COMMON_NAME,
        options = list(
          `live-search` = TRUE,
          `actions-box` = TRUE,
          `virtual-scroll` = TRUE
        ),
        multiple = FALSE
      )
    ),
    mainPanel(
      uiOutput("bird_info")
    )
)


server <- function(input, output) {
  
  # guessing counter to go here, something that doesn't loop forever and slow things down pls
  
  output$bird_info <- renderUI({
    selected_bird <- input$bird_search
    if (!is.null(selected_bird) && selected_bird %in% birds$COMMON_NAME) {
      bird_info <- birds[birds$COMMON_NAME == selected_bird, ]
      div(
        h3(bird_info$COMMON_NAME),
        h4(bird_info$LATIN_NAME),
        h5(bird_info$FAMILY)
      )
      
      # another if statement seeing what the shared ancestry is between answer and selected_bird
      
    } else {
      p("Select a bird to see its information.")
    }
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
