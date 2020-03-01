{rei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")} # Open data
{library(plyr)
library(ggplot2)
library(tidyr)
type <- unique(rei$type) ; type
rei_2 <- subset(rei, rei$fips == "24510")
data_point <- split(rei_2[,4], list(rei_2$year, rei_2$type))
data_point_plot <- ldply(data_point, sum)
asdf <- separate(data_point_plot, col = ".id", into =  c("year","type"), sep = "\\.", fill = "right") ; names(asdf) <- c("year", "type", "emissions")

final <- qplot(year, emissions, data = asdf, facets = .~type)
final + geom_point() + geom_text(aes(label = round(emissions, digits = 3), hjust = 0, vjust = -1))} #3
dev.copy(png, file = "Plot 3.png")
dev.off()