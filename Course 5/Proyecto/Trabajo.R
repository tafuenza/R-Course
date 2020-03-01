library(tidyverse)
library(ggplot2)
library(tidyr)
library(dplyr)
data <- read.csv("repdata_data_StormData.csv", header = TRUE)
#I create a data subset with the variables:
#BGN_DATE, EVTYPE, FATALITIES, INJURIES, PROPDMG, PROPDMGEXP, CROPDMG, CROPDMGEXP
data_final <- data[,c(8,23,24,25,26,27,28)]
#Change to date
data_final$EVTYPE <- as.character(data_final$EVTYPE)
#Count how many events by type there are
aux <- table(data_final$EVTYPE)
#Sort the vector decreasing
aux <- sort.int(aux, decreasing = TRUE)
#Get the top 10 events
aux <- aux[1:10]
#I adhere to a new column that includes the amount of total events of that type for each observation
data_final$aux2 <- match(data_final$EVTYPE, names(aux))
#Remove events that have the auxiliary variables like NA
data_final <- data_final %>% drop_na("aux2")
#Finaly we have only 20 types of events

propdmg_type_mean <- tapply(data_final$PROPDMG, data_final$EVTYPE, mean)
aux1 <- data.frame("Event" = names(propdmg_type_mean), "Propdamage" = as.numeric(propdmg_type_mean))
cropdmg_type_mean <- tapply(data_final$CROPDMG, data_final$EVTYPE, mean)
aux1$Cropdamage <- as.numeric(cropdmg_type_mean)
aux1$Totaldamage <- aux1$Propdamage + aux1$Cropdamage


aux2 <- aux1 %>% gather(Damage, Value, -Event)

ggplot(aux2, aes(x = Event, y = Value, fill = Damage)) + geom_col(position = "dodge") + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        scale_fill_manual(values=c("red", "#E69F00", "#56B4E9"))

fatalities_type_mean <- tapply(data_final$FATALITIES, data_final$EVTYPE, mean)
aux3 <- data.frame("Event" = names(fatalities_type_mean), "fatalities" = as.numeric(fatalities_type_mean))
injuries_type_mean <- tapply(data_final$INJURIES, data_final$EVTYPE, mean)
aux3$injuries <- as.numeric(injuries_type_mean)
aux3$totaldamage <- aux3$injuries + aux3$fatalities


aux4 <- aux3 %>% gather(Damage, Value, -Event)

ggplot(aux4, aes(x = Event, y = Value, fill = Damage)) + geom_col(position = "dodge") + 
        theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
        scale_fill_manual(values=c("Red", "darkgreen", "Blue"))
