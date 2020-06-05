library(shiny)

shinyServer(function(input, output) {
        
        output$text1 = renderText(input$slider2) 
        #Al slider 2 nombre que le pusimos al slider le genero la funcion rendertext que es
        #Para entregar texto, y defino el output como "text1"
})