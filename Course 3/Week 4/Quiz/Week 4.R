library(tidyr)
library(janitor)
data <- read.csv("getdata_data_ss06hid (1).csv")
names <-strsplit(names(data),"wgtp")
names[123]
data2 <- read.csv("getdata_data_GDP.csv", na.strings = c("","NA"))
grep("^United",data2$X.2)
?grep

# Otra pregunta

data1 <- read.csv("getdata_data_EDSTATS_Country.csv")
data2 <- read.csv("getdata_data_GDP.csv")
data3 <- merge(data1,data2,by.x = "CountryCode", by.y = "X")

        
## Otra
install.packages("quantmod")
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
data <- data.frame(sampleTimes)
data2 <- data.frame(data[data$sampleTimes >= "2012-01-01" & data$sampleTimes < "2013-01-01",])
data3 <- data.frame(weekdays(data2[[1]]))
data3 <- data.frame(data3[data3$weekdays.data2..1... == "miércoles",])
