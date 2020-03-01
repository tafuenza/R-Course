{rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")} # Open data
{library(plyr)
        library(dplyr)
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
dev.copy(png, "Plot4.png")
dev.off()
