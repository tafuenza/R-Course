#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI<- fluidPage(
        p("The checkbox group controls the select input"),
        checkboxGroupInput("inCheckboxGroup", "Input checkbox",
                           c("Item A", "Item B", "Item C")),
        selectInput("inSelect", "Select input",
                    c("Item A", "Item B", "Item C"))
)
