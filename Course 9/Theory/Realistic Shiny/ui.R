library(shiny)

shinyUI(fluidPage(
       titlePanel("Plot Random Numbers"),
       sidebarPanel(
               numericInput("numeric", "How Many Random Numbers Should be Plotted",
                            value = 20, min = 1, max = 1000, step = 1), #Permite pedir un numero al usuario
               sliderInput("sliderx", "Pick Minimum and Maximum X Values",
                           min = -100, max = 100, value = c(-50,50)),
               sliderInput("slidery", "Pick Minimum and Maximum Y Values",
                           min = -100, max = 100, value = c(-50,50)), #Son sliders dobles permite mover maximo y minimo
               checkboxInput("show_xlab", "Show/Hide X Axis Label", value = TRUE), #Permite crear un boton para activar o desactivar algo
               checkboxInput("show_ylab", "Show/Hide Y Axis Label", value = TRUE),
               checkboxInput("show_title", "Show/Hide Title", value = TRUE)
       ),
       mainPanel(
               h3("Graph of Random Points"),
               textOutput("avgx"),
               textOutput("avgy"),
               plotOutput("plot1")
       )
  
))
