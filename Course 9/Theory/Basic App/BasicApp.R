#Con runApp() puedo correr la app
#Con ?builder me entrega los comandos de HTML que se puede usar
#Con CTRL+U puedo ir y ver el codigo en HTML
library(shiny)

shinyUI(fluidPage( #FluidPage es un tipo de interfaz
        titlePanel("Data science FTW!"), #Entrega el titulo del panel que me refiero
        sidebarLayout( #Sidebar es una barra lateral
                sidebarPanel( #Nos dice que va a ocurrir en el sidebar
                        h3("Sidebar Text") #h3 hace referencia a la jerarquia de los textos h3<h2
                ),
                mainPanel(
                        h3("Main Panel Text")
                )
        )
))