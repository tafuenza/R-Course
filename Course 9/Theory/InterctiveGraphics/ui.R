library(shiny)

shinyUI(fluidPage(
        titlePanel("Title"),
        tabsetPanel(
                tabPanel(
                        "Test",
                        sidebarLayout(
                                sidebarPanel(
                                        sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
                                ),
                                mainPanel(
                                        plotOutput("distPlot")
                                )
                        )
                ),
                tabPanel("Second Test", h3("Test"))
        )
))
