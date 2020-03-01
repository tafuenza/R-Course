{data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), na = "?")
hpc <- data
hpc$datetime <- paste(hpc$Date,hpc$Time)
hpc$datetime <- as.POSIXct(hpc$datetime, format = "%d/%m/%Y %H:%M:%S")
hpc <- hpc[,3:10]
hpc <- subset(hpc, hpc$datetime >= "2007-02-01 00:00:00" & hpc$datetime <= "2007-02-02 23:59:59")} #Open the file and create date_times
{png("plot1.png")
        with(hpc, hist(Global_active_power, col = "brown1", xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
        dev.off()} #Plot 1