library(plyr)
rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds") # Open data
aux <- split(rei[,4], rei$year)
total_em <- ldply(aux, sum) ; names(total_em) <- c("year", "emissions")
mean_em <- ldply(aux, mean) ; names(mean_em) <- c("year", "emissions")
par(mfrow = c(1,2))
with(total_em, plot(year, log10(emissions), xlab = "Year", ylab = "log10(Emissions)", pch = 19, col = "red",
                    main = "Total Emissions per Year", type = "b", ylim = c(6.5,6.9), xlim = c(1998,2008)))
with(total_em, text(year, log10(emissions), round(log10(emissions), digits = 3), cex = 0.65, pos = 3))
with(mean_em, plot(year, emissions, xlab = "Year", ylab = "Emissions", pch = 19, col = "red",
                   main = "Mean of emission per year", type = "b", ylim = c(1.8,6.7), xlim = c(1998,2008)))
with(mean_em, text(year, emissions, round(emissions, digits = 3), cex = 0.65, pos = 3))
dev.copy(png, file = "Plot1.png")
dev.off()
