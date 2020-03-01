{data <- read.csv("household_power_consumption.txt", sep = ";", colClasses = c("character","character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric"), na = "?")
hpc <- data
hpc$datetime <- paste(hpc$Date,hpc$Time)
hpc$datetime <- as.POSIXct(hpc$datetime, format = "%d/%m/%Y %H:%M:%S")
hpc <- hpc[,3:10]
hpc <- subset(hpc, hpc$datetime >= "2007-02-01 00:00:00" & hpc$datetime <= "2007-02-02 23:59:59")} #Open the file and create date_times
{png("plot4.png")
        par(mfrow = c(2,2), mar = c(4,4,1,1))
        {plot(hpc$datetime,hpc$Global_active_power, ylab = "Global Active Power", type = "n", xlab = "")
                lines(hpc$datetime,hpc$Global_active_power, col = "black")}
        {plot(hpc$datetime,hpc$Voltage, ylab = "Voltage", type = "n", xlab = "datetime")
                lines(hpc$datetime,hpc$Voltage, col = "black")}
        {plot(hpc$datetime,hpc$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
                lines(hpc$datetime,hpc$Sub_metering_1, col = "black")
                lines(hpc$datetime,hpc$Sub_metering_2, col = "red")
                lines(hpc$datetime,hpc$Sub_metering_3, col = "Blue")
                legend("topright", col = c("black","red","blue"), legend = c("sub_metering_1","sub_metering_2","sub_metering_3"), pch = "-")}
        {plot(hpc$datetime,hpc$Global_reactive_power, ylab = "Global_reactive_power", type = "n", xlab = "datetime")
                lines(hpc$datetime,hpc$Global_reactive_power, col = "black")}
        dev.off()} #Plot 4