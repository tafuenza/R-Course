{rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")} # Open data
{library(plyr)
        rei1 <- subset(rei, rei$fips == "24510")
        data1 <- split(rei1[,4], rei1$year)
        total_em_1 <- ldply(data1, sum) ; names(total_em_1) <- c("year", "emissions")
        mean_em_1 <- ldply(data1, mean) ; names(mean_em_1) <- c("year", "emissions")
        
        with(total_em_1, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red", main = "Total Emissions per Year in Baltimore City", ylim = c(3.2, 3.6), type = "b", xlim = c(1998,2008)))
        with(total_em_1, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
        with(mean_em_1, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red", main = "Mean of emission per year in Baltimore City", type = "b", ylim = c(3,11), xlim = c(1998,2008)))
        with(mean_em_1, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))} #2
dev.copy(png, file = "Plot2.png")
dev.off()