install.packages("splus2R")
library(splus2R)
library(dplyr)
setwd("C:/Users/Casa/Desktop/Course R/Course-R/Course 2/Week 4")
getwd()
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
ncol(outcome)
nrow(outcome)
outcome[, 11] <- as.numeric(outcome[, 11])
## You may get a warning about NAs being introduced; that is okay
hist(outcome[, 11])

best <- function(state, outcome){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- data[data$State == state,]
        if (nrow(x) == 0){
                stop("invalidad outcome")
        }
        else if (outcome == as.character("heart attack")){
                        x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                        d <- subset(x, x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack==min(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, na.rm=TRUE))
                        print(d[,2])
                }
        else if (outcome == "heart failure"){
                        x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                        d <- subset(x, x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure==min(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, na.rm=TRUE))
                        print(d[,2])
                }
        else if (outcome == "pneumonia"){
                        x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
                        d <- subset(x, x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia==min(x$Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, na.rm=TRUE))
                        print(d[,2])
                }
        else {
                        print("the disease does not exist (outcome)")
                }
        }
  

best("TAX", "heart attack")
best("TX", "heart failure")
best("MD", "heart attack")
best("MD", "pneumonia")
best("BB", "heart attack")


a <- outcome[outcome$Hospital.Name == "FORT DUNCAN MEDICAL CENTER",] ## columna 17

rankhospital <- function (state, outcome, num = "best"){
        library(dplyr)
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        x <- data[data$State == state,]
        if (num == "best"){
                num <- 1
        }
        else if (nrow(x) == 0){
                stop("invalidad outcome")
                
        }
        if (outcome == "heart attack"){
                        x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack<- as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
                        d <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,x$Hospital.Name),]
                        z <- select(d,2,17)
                        z$Rank <- 1:nrow(z)
                        z <- na.omit(z)
                        if (num == "worst"){
                                return(z[nrow(z),])
                        }
                        else if (num > nrow(z)){
                                return(NA)
                        }
                        return(head(z,num))
                }
        else if (outcome == "heart failure"){
                        x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <- as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
                        d <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,x$Hospital.Name),]
                        z <- select(d,2,17)
                        z$Rank <- 1:nrow(z)
                        z <- na.omit(z)
                        if (num == "worst"){
                                return(z[nrow(z),])
                        }
                        else if (num > nrow(z)){
                                return(NA)
                        }
                        return(head(z,num))
                }
        else if (outcome == "pneumonia"){
                        x$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <- as.numeric(x$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
                        d <- x[order(x$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,x$Hospital.Name),]
                        z <- select(d,2,17)
                        z$Rank <- 1:nrow(z)
                        z <- na.omit(z)
                        if (num == "worst"){
                                return(z[nrow(z),])
                        }
                        else if (num > nrow(z)){
                                return(NA)
                        }
                        return(head(z,num))
                }
        else {
                        stop("invalid outcome")
                }
}

rankhospital("TX","heart failure", 5)


reto <- function(x,num){
  if (length(x$Rank) > num){
    x <- x[x$Rank %in% num,]
  }
  else {
    x[1,1] <- NA
    return(x[1,])
  }
  
}

rankall <- function(outcome, num = "best"){
        data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
        data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <- as.numeric(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
        if (num == "best"){
                num <- 1
        }
        if (outcome == "heart attack"){
                data <- data[order(data$State,data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack),]
                data <- select(data,2,7,11)
                data <- na.omit(data)
                data <- split(data, data$State)
                data <- lapply(data,function(x){x$Rank <- 1:nrow(x);return(x)})
                data_1 <- lapply(data,reto,num)
                z <- bind_rows(data_1, .id = "column_label")
                z <- z[,1:3]
                return(z)
        }
        else if (outcome == "heart failure"){
                data <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure),]
                data <- select(data,2,7,17)
                data <- na.omit(data)
                data <- split(data, data$State)
                data <- lapply(data,function(x){x$Rank <- 1:nrow(x);return(x)})
                data_1 <- lapply(data,reto,num)
                z <- bind_rows(data_1, .id = "column_label")
                z <- z[,1:3]
                return(z)
                
        }
        else if (outcome == "pneumonia"){
                data <- data[order(data$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia),]
                data <- select(data,2,7,23)
                data <- na.omit(data)
                data <- split(data, data$State)
                data <- lapply(data,function(x){x$Rank <- 1:nrow(x);return(x)})
                data_1 <- lapply(data,reto,num)
                z <- bind_rows(data_1, .id = "column_label")
                z <- z[,1:3]
                return(z) 
                
        }
        else {
                stop("invalid outcome")
        }
        

}

best("SC", "heart attack")
best("NY", "pneumonia")
best("AK", "pneumonia")
rankhospital("NC", "heart attack", "worst")
rankhospital("WA", "heart attack", 7)
rankhospital("TX", "pneumonia", 10)
rankhospital("NY", "heart attack", 7)
r <- rankall("heart attack", 4)
r
as.character(subset(r, State == "HI")$Hospital.Name)
r <- rankall("pneumonia", "worst")
as.character(subset(r, State == "NJ")$Hospital.Name)
r <- rankall("heart failure", 10)
as.character(subset(r, State == "NV")$Hospital.Name)


