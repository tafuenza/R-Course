{pm0 <- read.table("1999.txt", header = FALSE, sep = "|", na.strings = "", comment.char = "#")
pm1 <- read.table("2012.txt", header = FALSE, sep = "|", na.strings = "", comment.char = "#")}
cnames <- readLines("1999.txt",1)
cnames <- strsplit(cnames, "|", fixed = TRUE)
names(pm0) <- cnames[[1]] ; names(pm1) <- cnames[[1]]
names(pm0) <- make.names(cnames[[1]]) ; names(pm1) <- make.names(cnames[[1]]) #Convierte los nombres en algo legible para R y que no tengan espacios
x0 <- pm0$`Sample Value`
class(x0)
str(x0)
summary(x0)
mean(is.na(x0)) #CQue porcentaje de las observaciones son Nas
x1 <- pm1$`Sample Value`
class(x1)
str(x1)
summary(x1)
mean(is.na(x1))
boxplot(x0,x1)
boxplot(log10(x0),log10(x1))# La media bajo, pero la desviacion en 2012 subio
negative <- x1 < 0 #Me da un vector de TRUE o FALSE que cumplen la condicion
negative
sum(negative, na.rm = TRUE) #Existen mas 26.000 que son negativos
mean(negative, na.rm = TRUE)
dates <- pm1$Date
str(dates)
dates <- as.Date(as.character(dates), "%Y%m%d")
str(dates)
hist(dates, "month")
hist(dates[negative], "month")

#Tomar un monito y compararlo

site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID))) #Creo un subset del estado "36" con las variables County.Code y Site.ID
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))
site0 <- paste(site0[,1],site0[,2], sep = ".")
site1 <- paste(site1[,1],site1[,2], sep = ".")
both <-  intersect(site0,site1)
both
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))
cnt0 <- subset(pm0, State.Code & county.site %in% both) #Creo un sebste que contenga los monitores
cnt1 <- subset(pm1, State.Code & county.site %in% both)
sapply(split(cnt0, cnt0$county.site),nrow)
sapply(split(cnt1, cnt1$county.site),nrow)
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
dates1 <- pm1sub$Date
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
plot(dates1, x1sub)
dates0 <- pm0sub$Date ; dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)
rng <- range(x0sub, x1sub, na.rm = TRUE)
par(mfrow = c(1,2), mar = c(4,4,2,1))
plot(dates0, x0sub, ylim = rng)
abline(h = median(x0sub, na.rm = TRUE))
plot(dates1, x1sub, ylim = rng)
abline(h = median(x1sub, na.rm = TRUE))

#Cambio en un estado

mean0 <- with(pm0, tapply(Sample.Value, State.Code,mean, na.rm = TRUE))
summary(mean0)
mean1 <- with(pm1, tapply(Sample.Value, State.Code,mean, na.rm = TRUE))
summary(mean1)
d0 <- data.frame(state = names(mean0), mean = mean0)
d1 <- data.frame(state = names(mean1), mean = mean1)
mrg <- merge(d0,d1, by = "state")
par(mfrow = c(1,1))
with(mrg, plot(rep(1999,52), mrg[, 2], xlim = c(1998,2013)))
with(mrg, points(rep(2012,52), mrg[,3]))
segments(rep(1999,52), mrg[,2], rep(2012,52), mrg[,3])
        