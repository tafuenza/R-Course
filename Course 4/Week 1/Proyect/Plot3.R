{data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), na = "?")
hpc <- data
hpc$datetime <- paste(hpc$Date,hpc$Time)
hpc$datetime <- as.POSIXct(hpc$datetime, format = "%d/%m/%Y %H:%M:%S")
hpc <- hpc[,3:10]
hpc <- subset(hpc, hpc$datetime >= "2007-02-01 00:00:00" & hpc$datetime <= "2007-02-02 23:59:59")} #Open the file and create date_times
{png("plot3.png")
        par(mar = c(3,4,1,1))
        plot(hpc$datetime,hpc$Sub_metering_1, type = "n", ylab = "Energy sub metering")
        lines(hpc$datetime,hpc$Sub_metering_1, col = "black")
        lines(hpc$datetime,hpc$Sub_metering_2, col = "red")
        lines(hpc$datetime,hpc$Sub_metering_3, col = "Blue")
        legend("topright", col = c("black","red","blue"), legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), pch = "-")
        dev.off()} #Plot 3