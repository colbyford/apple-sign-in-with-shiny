## Apple Sign On Button Generation in Shiny
## By: Colby T. Ford, Ph.D.
library(shiny)
source("rapple.R")

ui <- fluidPage(
    titlePanel("Apple Sign In with Shiny"),

    sidebarLayout(
        sidebarPanel(
            textInput("client_id",
                      "Client ID",
                      value = "com.site.app"),
            textInput("redirect_uri",
                      "Redirect URI",
                      value = "https://mysite.com"),
            textInput("state",
                      "State",
                      value = paste0(sample(c(0:9, LETTERS[1:6]), 5, T), collapse = '')),
            submitButton(text = "Make Button")
            
            
        ),

        # Show a plot of the generated distribution
        mainPanel(
           # htmlOutput("apple_btn_html"),
           uiOutput("apple_btn_url")
        )
    )
)

# Define server logic
server <- function(input, output) {

    # output$apple_btn_html <- renderText({
    #     apple_button(client_id = input$client_id,
    #                  redirect_uri = input$redirect_uri,
    #                  state = input$state,
    #                  return_type = "html")
    #     })
    
    output$apple_btn_url <- renderUI({
        apple_url <- apple_button(client_id = input$client_id,
                                  redirect_uri = input$redirect_uri,
                                  state = input$state,
                                  return_type = "url")
        
        actionButton("apple_btn",
                     label = "Sign in with Apple",
                     icon = icon("apple"),
                     onclick = paste0("window.open('", apple_url, "', '_blank')"))
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
