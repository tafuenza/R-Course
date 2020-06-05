library(shiny)
library(leaflet)
library(lubridate)
library(ggplot2)
data<- read.csv("database.csv", header = TRUE, sep = ","); data <- data[,c(1,3,4,5,6,9)]
data$Date <- mdy(data$Date); data <- na.omit(data); data$Numero <- 1:length(data[,1])
data$Latitude <- as.integer(data$Latitude); data$Longitude <- as.integer(data$Longitude)

shinyServer(function(input, output,session) {
        observe({
                updateSelectInput(session, "month", selected = input$month)
        })
        observe({
                updateSelectInput(session, "day", selected = input$day)
        })

        output$map <- renderLeaflet({
                {min_year <- input$year[1]
                max_year <- input$year[2]
                min_magni <- input$magni
                min_depth <- input$depth
                month_select <- input$month
                day_select <- input$day
                data <- subset(data,year(Date)>= min_year & year(Date) <= max_year &
                               month(Date) %in% month_select & wday(Date) %in% day_select &
                                Magnitude >= min_magni & Depth >= min_depth)} #Filter Data
                        data %>%
                        leaflet() %>%
                        addTiles() %>%
                        addMarkers(lng = ~Longitude, lat = ~Latitude,
                                   clusterOptions = markerClusterOptions(),
                                   popup = ~as.character(paste("Depth",Depth, "<br>",
                                                               "Magnitude",Magnitude,"<br>",
                                                               "Longitude", Longitude,"<br>",
                                                               "Latitude", Latitude)))
        })
        output$plot <- renderPlot({
                {min_year <- input$year[1]
                max_year <- input$year[2]
                min_magni <- input$magni
                min_depth <- input$depth
                month_select <- input$month
                day_select <- input$day
                data <- subset(data,year(Date)>= min_year & year(Date) <= max_year &
                                       month(Date) %in% month_select & wday(Date) %in% day_select &
                                       Magnitude >= min_magni & Depth >= min_depth)} #Filter Data
                ggplot(data, aes(Depth,Magnitude)) +
                        geom_point(color = "blue") +
                        geom_smooth(method = 'lm', formula = y ~ x, se = F, col = "red", show.legend = TRUE)
                
        })
        output$data <- DT::renderDataTable({
                {min_year <- input$year[1]
                max_year <- input$year[2]
                min_magni <- input$magni
                min_depth <- input$depth
                month_select <- input$month
                day_select <- input$day
                data <- subset(data,year(Date)>= min_year & year(Date) <= max_year &
                                       month(Date) %in% month_select & wday(Date) %in% day_select &
                                       Magnitude >= min_magni & Depth >= min_depth)} #Filter Data
                data})
        output$text <- renderText("In this application, the earthquake data from the years 1956 to 2016, obtained
                                from the kaggle website, were used:https://www.kaggle.com/usgs/earthquake-database.
                                In the bar on the right side it is possible to filter earthquakes by different parameters (Year, Month, Day, Magnitude, Depth).
                                Then in the maps tab you can find the location of each of the earthquakes as well as their coordinates, magnitude and depth.
                                In the graph tab there is a graph of Depth v / s Magnitude and a linear regression of the selected earthquakes.
                                Finally, in the dataset tab you can find all the observations that meet the parameters specified in the bar")
})
