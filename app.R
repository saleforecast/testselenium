# app.R
library(shiny)
library(RSelenium)

ui <- fluidPage(
  actionButton("btn", "Click Me"),
  textOutput("result")
)

server <- function(input, output, session) {
  # Start the remote driver
  remDr <- remoteDriver(
    remoteServerAddr = Sys.getenv("SELENIUM_HOST", "localhost"),
    port =  as.integer(Sys.getenv("SELENIUM_PORT", "4445")), 
    browserName = "chrome",
  )
  observeEvent(input$btn, {
      output$result <- renderText({
        remDr$open()
  
        # Navigate to a website (e.g., Google)
        remDr$navigate("https://www.google.com")
        remDr$maxWindowSize()
  
        # Perform some actions (e.g., print page title)
        title <- remDr$getTitle()
        
        return(as.character(title))
      })
      
})
  session$onSessionEnded(function() {
    # Close the remote driver
    remDr$close()
  })
}

shinyApp(ui, server)
