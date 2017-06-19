#plot4.R

household <- read.table("household_power_consumption.txt",header=T,sep = ";") 
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
#filtering by dates
household1 <- household[(household$Date == "2007-02-01") | (household$Date =="2007-02-02"),]

dates <- household1$Date
times <- household1$Time
X <- paste(dates, times)
dateantime <- strptime(X, "%Y-%m-%d %H:%M:%S")

household1$Global_active_power <- as.numeric(as.character(household1$Global_active_power ))
household1$Voltage <- as.numeric(as.character(household1$Voltage))
household1$Global_reactive_power <- as.numeric(as.character(household1$Global_reactive_power))

household1$Sub_metering_1 <- as.numeric(as.character(household1$Sub_metering_1))
household1$Sub_metering_2 <- as.numeric(as.character(household1$Sub_metering_2))
household1$Sub_metering_3 <- as.numeric(as.character(household1$Sub_metering_3))


par(mfrow = c(2, 2), mar = c(4,4,2,1), oma = c(0,0,2,0))

plot(dateantime, household1$Global_active_power, type="l",xlab = "", ylab = "Global Active Power")

plot(dateantime, household1$Voltage, type="l",xlab = "datetime", ylab = "Voltage")

plot(dateantime, household1$Sub_metering_1, type="l",xlab = "", ylab = "Energy sub metering")
lines(dateantime,household1$Sub_metering_2, col = "red")
lines(dateantime,household1$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty = 1, lwd = 2.5)

plot(dateantime, household1$Global_reactive_power, type="l",xlab = "datetime", ylab = "Global_reactive_power")

dev.copy(png, file = "plot4.png", width=480, height=480) 
dev.off()