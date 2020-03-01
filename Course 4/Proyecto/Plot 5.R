{rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")} # Open data
{library(plyr)
        rei_5 <- subset(rei, rei$type == "ON-ROAD")
        aux <- split(rei_5[,4], rei_5$year)
        total_em <- ldply(aux, sum) ; names(total_em) <- c("year", "emissions")
        mean_em <- ldply(aux, mean) ; names(mean_em) <- c("year", "emissions")
        
        with(total_em, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red", main = "Total Emissions per Year (ON-ROAD)", type = "b", ylim = c(5,5.3), xlim = c(1998,2008)))
        with(total_em, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
        with(mean_em, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red", main = "Mean of emission per year (ON-ROAD)", type = "b", ylim = c(0.1,0.4), xlim = c(1998,2008)))
        with(mean_em, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #5
dev.copy(png, file = "Plot5.png")
dev.off()
