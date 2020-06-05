library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$plot1 <- renderPlot({
                set.seed(2016-05-25)
                number_of_points <- input$numeric
                minX <- input$sliderx[1]# Los sliders dobles entregan dos parametros como un vector
                maxX <- input$sliderx[2]
                minY <- input$slidery[1]
                maxY <- input$slidery[2]
                dataX <- runif(number_of_points, min = minX, max = maxX)
                dataY <- runif(number_of_points, min = minY, max = maxY)
                xlab <- ifelse(input$show_xlab, "X Axis", "") #Checkbox entrega un TRUE or FALSE si esta prendido o apagoado por eso se usa ifelse
                ylab <- ifelse(input$show_ylab, "Y Axis", "")
                main <- ifelse(input$showx_title, "Title", "")
                plot(dataX,dataY, xlab = xlab, ylab = ylab, main = main,
                        xlim = c(-100,100), ylim = c(-100,100))
        
        output$avgx = renderText({
                avgx <- mean(dataX)
                paste("Average of X numbers: ", avgx)
                 })
        output$avgy = renderText({
                avgy <- mean(dataY)
                paste("Average of Y numbers: ", avgy)

                })  #Los corchetes de llaves se utilizan para definir codigo que es "reactivo" que interactua con el usuario
        })
})
