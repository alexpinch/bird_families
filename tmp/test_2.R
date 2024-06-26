# Alex Pinch, June 19 2024

library(shiny)
library(shinyWidgets)

birds <- read.csv("/Users/alexpinch/GitHub/private/phyl_bird/birds.csv", header = TRUE)

# selecting the answer
num_rows <- nrow(birds)
random_row <- sample(1:num_rows, 1)
answer <- birds[random_row, 1]

ui <- fluidPage(
  titlePanel("phyl_bird!!"),
  p("Text w rules about the game to go here", answer),
  
  uiOutput("dynamic_sidebar"),
  mainPanel(
    uiOutput("bird_info")
  )
)

server <- function(input, output, session) {
  # Reactive values to keep track of the game state
  values <- reactiveValues(guesses = 0, game_over = FALSE)
  
  # Dynamically generate the sidebarPanel
  output$dynamic_sidebar <- renderUI({
    if (!values$game_over) {
      sidebarPanel(
        selectizeInput(
          inputId = "bird_search", 
          label = "Search for a bird:", 
          choices = NULL, # Initially no choices to display
          options = list(
            placeholder = 'Type to search...',
            maxOptions = 1000,
            value = NULL # Ensuring the initial value is NULL
          )
        ),
        actionButton("submit_guess", "Submit Guess"),
        textOutput("guess_count")
      )
    } else {
      mainPanel(
        h4(if (input$bird_search == answer) {
          "Congratulations! You've guessed the correct bird!"
        } else {
          "You lose!"
        }),
        h4(paste("The correct bird was:", answer))
      )
    }
  })
  
  # Update selectizeInput choices based on the user input
  updateSelectizeInput(session, 'bird_search', choices = birds$COMMON_NAME, server = TRUE)
  
  observeEvent(input$submit_guess, {
    # Increment the guess count
    values$guesses <- values$guesses + 1
    
    # Check if the user has guessed the correct bird
    if (input$bird_search == answer || values$guesses >= 5) {
      values$game_over <- TRUE
    }
  })
  
  output$bird_info <- renderUI({
    if (values$game_over) {
      return()
    }
    
    selected_bird <- input$bird_search
    if (!is.null(selected_bird) && selected_bird != "" && selected_bird %in% birds$COMMON_NAME) {
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
  
  output$guess_count <- renderText({
    if (values$game_over) {
      return()
    }
    paste("Guesses used:", values$guesses, "out of 5")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
