{data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), na = "?")
hpc <- data
hpc$datetime <- paste(hpc$Date,hpc$Time)
hpc$datetime <- as.POSIXct(hpc$datetime, format = "%d/%m/%Y %H:%M:%S")
hpc <- hpc[,3:10]
hpc <- subset(hpc, hpc$datetime >= "2007-02-01 00:00:00" & hpc$datetime <= "2007-02-02 23:59:59")} #Open the file and create date_times
{png("plot2.png")
        plot(hpc$datetime,hpc$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
        lines(hpc$datetime,hpc$Global_active_power)
        dev.off()} #Plot 2