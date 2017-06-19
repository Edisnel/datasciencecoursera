#plot3.R

household <- read.table("household_power_consumption.txt",header=T,sep = ";") 
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
#filtering by dates
household1 <- household[(household$Date == "2007-02-01") | (household$Date =="2007-02-02"),]

dates <- household1$Date
times <- household1$Time
X <- paste(dates, times)
dateantime <- strptime(X, "%Y-%m-%d %H:%M:%S")

household1$Sub_metering_1 <- as.numeric(as.character(household1$Sub_metering_1))
household1$Sub_metering_2 <- as.numeric(as.character(household1$Sub_metering_2))
household1$Sub_metering_3 <- as.numeric(as.character(household1$Sub_metering_3))

plot(dateantime, household1$Sub_metering_1, type="l",xlab = "", ylab = "Energy sub metering")
lines(dateantime,household1$Sub_metering_2, col = "red")
lines(dateantime,household1$Sub_metering_3, col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), lwd=c(1,1))
dev.copy(png, file = "plot3.png", width=480, height=480) 
dev.off()

