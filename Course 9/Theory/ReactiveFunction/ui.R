library(shiny)

shinyUI(fluidPage(
  titlePanel("P^redict Horsepower from MPG"),
  sidebarLayout(
          sidebarPanel(
                  sliderInput("sliderMPG", "What is the MPG of the car?", min = 10, max = 35, value = 20),
                  checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                  checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                  submitButton("Submit")
          ),
          mainPanel(
                plotOutput("plot1"),
                h3("predicted Horsepower from Model 1: "),
                textOutput("pred1"),
                h3("predicted Horsepower from Model 2: "),
                textOutput("pred2")
          )
  )
))
