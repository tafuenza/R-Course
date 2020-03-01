{rei <- readRDS("summarySCC_PM25.rds")
        scc <- readRDS("Source_Classification_Code.rds")} # Open data
{library(plyr)
        library(ggplot2)
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
dev.copy(png, "Plot6.png")
dev.off()
