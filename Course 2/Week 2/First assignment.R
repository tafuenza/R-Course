setwd("C:\\Users\\Casa\\Desktop\\Curso R\\Curso-Especializacion-R\\Course 2\\Week 2")

getwd()
rm(list = ls())

library(plyr)
library(readr)

pollutantmean <- function(directory, pollutant, id = 1:332){
        myfiles <- list.files(path = directory, pattern=".csv", full.names=TRUE)
        corte <- myfiles[id]
        data <- ldply(corte, read_csv)
        return(mean(data[[pollutant]], na.rm = TRUE))

}
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 23)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
complete <- function(directory,id = 1:332){
        myfiles <- list.files(path = directory, pattern=".csv", full.names=TRUE)
        corte <- myfiles[id]
        data <- lapply(corte, read_csv)
        comp <- data.frame(id = integer(),nobs = integer())
        for (i in data){
                comp <- rbind(comp,list(id = i[[1,4]],nobs = nrow(na.omit(i))))
                }
        return(comp)
}
        
complete("specdata", 1)
complete("specdata", c(2, 4, 8, 10, 12))
complete("specdata", 30:25)
complete("specdata", 3)
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)

corr <- function(directory, threshhold = 0){
        sub <- complete(directory)
        data <- subset(sub, nobs > threshhold)
        myfiles <- list.files(path = directory, pattern=".csv", full.names=TRUE)
        corte <- myfiles[data$id]
        corte
        # data_1<- ldply(corte, read_csv)
        # data_2 <- na.omit(data_1)
        # return(cor(data_2$nitrate,data_2$sulfate))
}
cr <- corr("specdata", 150)
summary(cr)


pollutantmean("specdata", "sulfate", 1:10)
pollutantmean("specdata", "nitrate", 70:72)
pollutantmean("specdata", "sulfate", 34)
pollutantmean("specdata", "nitrate")
cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
print(cc$nobs)
cc <- complete("specdata", 54)
print(cc$nobs)
RNGversion("3.5.1")  
set.seed(42)
cc <- complete("specdata", 332:1)
use <- sample(332, 10)
print(cc[use, "nobs"])
