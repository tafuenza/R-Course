getwd()
setwd("C:\\Users\\Casa\\Desktop\\Course R\\Course-R\\Course 3\\Week 1")
read <- read.csv("getdata_data_ss06hid.csv", nrow = 10)
data <- read.csv("getdata_data_ss06hid.csv")
DT <- as.data.table(data)
DT[,Value:= VAL >= 24]
DT[,.N, by = Value]
read$FES

library("xlsx")
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", 1, colIndex = colIndex, rowIndex = rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)
library("XML")
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
download.file(url, destfile = "Baltimore.xml")
doc <- xmlTreeParse("Baltimore.xml", useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
x <- xpathSApply(rootNode,'//zipcode',xmlValue)
y <- data.table(as.list(x))
y[,A:= V1 == 21231]
y[,.N, by = A]
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "CS.csv")
DT <- fread("CS.csv")
class(data)
