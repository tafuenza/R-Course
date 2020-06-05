library(shiny)

shinyUI(fluidPage(
        titlePanel("Slider App"),
        sidebarLayout(
                sidebarPanel(
                        h1("Move the Slider!"),
                        sliderInput("slider2","Slide Me!",0,100,0)# Nombre, Titulo, desde 0 a 100 partiendo por 0
                ),
                mainPanel(
                        h3("Slider Value"),
                        textOutput("text1") #Aqui hacemos que el output del server "text1" se muestre
                )
        )
))
