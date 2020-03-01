library(lubridate)
library(lattice)
library(chron)
library(tidyr)
library(ggplot2)
library(dplyr)
data <- read.csv("activity.csv") ; data$date <- ymd(data$date) #Conver to date
aux <- split(data[,1], data$date) #Split by day
stepsperday <- sapply(aux, sum) # Sum day
#Histrogram sum steps per day
barplot(stepsperday, names.arg = unique(data$date), main = "Steps per day",
        xlab = "Days", ylab = "Steps", col = "darkgreen" )
avgstepsperday <- sapply(aux,mean) #Mean day
medianstepsperday <- sapply(aux,median) #Median day
#Time series plot average steps per day
aux1 <- split(data[,1], data$interval)
avgstepperinterval <- sapply(aux1,mean, na.rm = TRUE)
plot(unique(data$interval), avgstepperinterval, type = "l", main = "Time series plot of the average number of steps taken",
     xlab = "Interval", ylab = "Steps")
#The 5-minute interval that, on average, contains the maximum number of steps
avgstepinterval <- sapply(aux1, mean)
max(avgstepinterval)
#Histogram of the total number of steps taken each day after missing values are imputed
data <- na.omit(data)
aux2 <- split(data[,1], data$date)
stepsperdayNA <- sapply(aux2, sum)
barplot(stepsperdayNA, names.arg = unique(data$date), main = "Steps per day",
        xlab = "Days", ylab = "Steps", col = "darkgreen" )
#Panel plot comparing the average number of steps taken per 5-minute interval across weekdays and weekends
data$isweekend <- is.weekend(data$date)
data[,4] <- as.numeric(data[,4])
data$isweekend[data$isweekend == 0] <- "Weekday" ; data$isweekend[data$isweekend == 1] <- "Weekend"
aux3 <- split(data[,1], list(data$isweekend, data$interval))
aux4 <- sapply(aux3, mean)
data2 <- data.frame("days" = names(aux3), "steps" = aux4, row.names = NULL)
data2 <- data2 %>% separate(days, c("isweekend", "interval"))
data2$isweekend <- as.factor(data2$isweekend)

xyplot(data2$steps ~ data2$interval | data2$isweekend)

g <- qplot(as.numeric(data2$interval), data2$steps, data = data2, facets = .~isweekend, na.rm = TRUE, type = "l")
g + scale_x_continuous(breaks = seq(0, 2355, by =250)) +
labs(title = "Average steps per interval", x = "Interval", y = "Steps") +  geom_line(linetype = "solid")

?which.max

