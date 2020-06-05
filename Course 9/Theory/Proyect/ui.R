library(shiny)
library(leaflet)
library(lubridate)
mes <- list("January" = 1,"February" = 2,"March" = 3,"April" = 4,"May" = 5,
            "June" = 6,"July" = 7,"August" = 8,"September" = 9, "October" = 10,
            "November" = 11, "December" = 12)
day <- list("Monday" = 2, "Tuesday" = 3, "Wednesday" = 4, "Thursday" = 5, "Friday" = 6, "Saturday" = 7, "Sunday" = 1)
shinyUI(fluidPage(
        titlePanel("Earthquakes"),
        sidebarLayout(position = "right",
                sidebarPanel(
                        sliderInput("year", "Choose Year of the Earthquakes", min = 1965, max = 2016, value = c(1965,1966)),
                        sliderInput("magni", "Min Magnitude of the Earthquakes", min = 5.5, max = 9.1, value = 5.5),
                        sliderInput("depth", "Min Depth of the Earthquakes", min = 0, max = 700, value = 0),
                        selectizeInput(inputId = "month",label =  "Months", choices =  mes, selected = 2 , multiple  = TRUE),
                        selectizeInput(inputId = "day",label =  "Days", choices =  day, selected = day , multiple  = TRUE),
                        submitButton(text = "Refresh", icon("refresh"))
                ),
                mainPanel(
                        tabsetPanel(type = "tabs",
                                tabPanel("Map",br(), leafletOutput("map")),
                                tabPanel("Graph",br(), plotOutput("plot")),
                                tabPanel("Data",br(), DT::dataTableOutput("data")),
                                tabPanel("Documentation", br(), textOutput("text"))
                        )
                )
        )
))
