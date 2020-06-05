library(lubridate)
data<- read.csv("database.csv", header = TRUE, sep = ","); data <- data[,c(1,3,4,5,6,9)]
data$Date <- mdy(data$Date); data <- na.omit(data)
data$Latitude <- as.integer(data$Latitude); data$Longitude <- as.integer(data$Longitude)
data$Numero <- 1:length(data[,1])
wday(data[1,1])
mes <- list("Select All" = 0,"January" = 1,"February" = 2,"March" = 3,"April" = 4,"May" = 5,
            "June" = 6,"July" = 7,"August" = 8,"September" = 9, "October" = 10,
            "November" = 11, "December" = 12)
a <- lapply(mes[-1], function(x){c(x[[1]])})

a <- c(1,2,3,4,5,6,7,8,9,10,11,12)
class(as.character(a))
