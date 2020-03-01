library(plyr)
{rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")} # Open data
{year <- unique(rei$year)
aux <- split(rei[,4], year)
total_em <- ldply(aux, sum) ; names(total_em) <- c("year", "emissions")
mean_em <- ldply(aux, mean) ; names(mean_em) <- c("year", "emissions")

with(total_em, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red", main = "Total Emissions per Year", type = "b", ylim = c(6.7,6.8), xlim = c(1998,2008)))
with(total_em, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
with(mean_em, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red", main = "Mean of emission per year", type = "b", ylim = c(3.1,3.8), xlim = c(1998,2008)))
with(mean_em, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #1
{rei1 <- subset(rei, rei$fips == "24510")
data1 <- split(rei1[,4], rei1$year)
total_em_1 <- ldply(data1, sum) ; names(total_em_1) <- c("year", "emissions")
mean_em_1 <- ldply(data1, mean) ; names(mean_em_1) <- c("year", "emissions")

with(total_em_1, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red", main = "Total Emissions per Year in Baltimore City", ylim = c(3.2, 3.6), type = "b", xlim = c(1998,2008)))
with(total_em_1, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
with(mean_em_1, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red", main = "Mean of emission per year in Baltimore City", type = "b", ylim = c(3,11), xlim = c(1998,2008)))
with(mean_em_1, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #2
{library(ggplot2)
library(tidyr)
type <- unique(rei$type) ; type
rei_2 <- subset(rei, rei$fips == "24510")
data_point <- split(rei_2[,4], list(rei_2$year, rei_2$type))
data_point_plot <- ldply(data_point, sum)
asdf <- separate(data_point_plot, col = ".id", into =  c("year","type"), sep = "\\.", fill = "right") ; names(asdf) <- c("year", "type", "emissions")

final <- qplot(year, emissions, data = asdf, facets = .~type)
final + geom_point() + geom_text(aes(label = round(emissions, digits = 3), hjust = 0, vjust = -1))} #3
{library(dplyr)
scc_coal <- scc[,c(1,9)] ; names(scc_coal) <- c("SCC", "source") ; scc_coal[] <- lapply(scc_coal, as.character)
filter <- scc_coal[as.character(grep("Coal", scc_coal$source)),]
aux <- which(rei$SCC %in% filter$SCC) ; rei_coal <- rei[aux,]
final_total <- ldply(split(rei_coal[,4], rei_coal$year), sum); names(final_total) <- c("year","emissions")
final_mean <- ldply(split(rei_coal[,4], rei_coal$year), mean); names(final_mean) <- c("year","emissions")
rango <- range(log10(final_total$emissions))
with(final_total, plot(year,log10(emissions), xlab = "Year", ylab = "log10(Emissions)", main = "Total coal emissions per year", pch = 19, col = "red", type ="b", ylim = c(5.5,5.8), xlim = c(1998,2008)))
with(final_total, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
with(final_mean, plot(year,emissions, xlab = "Year", ylab = "Emissions", main = "Mean coal emissions per year", pch = 19, col = "red", type = "b" , ylim = c(20,62), xlim = c(1998,2008)))
with(final_mean, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #4
{rei_5 <- subset(rei, rei$type == "ON-ROAD")
aux <- split(rei_5[,4], rei_5$year)
total_em <- ldply(aux, sum) ; names(total_em) <- c("year", "emissions")
mean_em <- ldply(aux, mean) ; names(mean_em) <- c("year", "emissions")

with(total_em, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red", main = "Total Emissions per Year (ON-ROAD)", type = "b", ylim = c(5,5.3), xlim = c(1998,2008)))
with(total_em, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
with(mean_em, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red", main = "Mean of emission per year (ON-ROAD)", type = "b", ylim = c(0.1,0.4), xlim = c(1998,2008)))
with(mean_em, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #5
{library(ggplot2)
library(tidyr)
rei_2 <- subset(rei, rei$fips == "24510" | rei$fips == "06037")
data_point <- split(rei_2[,4], list(rei_2$year,rei_2$fips))
data_point_plot_total <- ldply(data_point, sum)
asdf <- separate(data_point_plot_total, col = ".id", into =  c("year","country"), sep = "\\.", fill = "right") ; names(asdf) <- c("year", "country", "emissions")
aux <- data.frame(country = c("Baltimore City", "Los Angeles Country"), fips = c("24510","06037"))
asdf[["country"]] <- aux[match(asdf[['country']], aux[['fips']] ) , 'country']
final_total <- qplot(year, log10(emissions), data = asdf, facets = .~country)
final_total + geom_point() + geom_text(aes(label = round(log10(emissions), digits = 3), hjust = 0, vjust = -1))
data_point_plot_mean <- ldply(data_point, mean)
asdf_mean <- separate(data_point_plot_mean, col = ".id", into =  c("year","country"), sep = "\\.", fill = "right") ; names(asdf_mean) <- c("year", "country", "emissions")
asdf_mean[["country"]] <- aux[match(asdf_mean[['country']], aux[['fips']] ) , 'country']
final_mean <- qplot(year, emissions, data = asdf_mean, facets = .~country)
final_mean + geom_point() + geom_text(aes(label = round(emissions, digits = 3), hjust = 0, vjust = -1))} #6