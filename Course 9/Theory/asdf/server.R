#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
        observe({
                x <- input$inCheckboxGroup
                
                # Can use character(0) to remove all choices
                if (is.null(x))
                        x <- character(0)
                
                # Can also set the label and select items
                updateSelectInput(session, "inSelect",
                                  label = paste("Select input label", length(x)),
                                  choices = x,
                                  selected = tail(x, 1)
                )
        })
})