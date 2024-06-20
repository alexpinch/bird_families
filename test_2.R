# Alex Pinch, June 15 2024

library(shiny)
library(shinyWidgets)

birds <- read.csv("/Users/alexpinch/GitHub/private/phyl_bird/birds.csv", header = TRUE)

# selecting the answer
num_rows <- nrow(birds)
random_row <- sample(1:num_rows, 1)
answer <- birds[random_row, 1]

ui <- fluidPage(
  titlePanel("phyl_bird!!"),
  p("Text w rules about the game to go here"),
  
  sidebarPanel(
    selectizeInput(
      inputId = "bird_search", 
      label = "Search for a bird:", 
      choices = NULL, # Initially no choices to display
      options = list(
        placeholder = 'Type to search...',
        maxOptions = 1000,
        value = NULL
      )
    )
  ),
  mainPanel(
    uiOutput("bird_info")
  )
)

server <- function(input, output, session) {
  
  # Update selectizeInput choices based on the user input
  updateSelectizeInput(session, 'bird_search', choices = birds$COMMON_NAME, server = TRUE)
  
  output$bird_info <- renderUI({
    selected_bird <- input$bird_search
    if (!is.null(selected_bird) && selected_bird %in% birds$COMMON_NAME) {
      bird_info <- birds[birds$COMMON_NAME == selected_bird, ]
      div(
        h3(bird_info$COMMON_NAME),
        h4(bird_info$LATIN_NAME),
        h5(bird_info$FAMILY)
      )
    } else {
      p("Select a bird to see its information.")
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
