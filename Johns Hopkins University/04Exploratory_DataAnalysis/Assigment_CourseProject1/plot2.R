#plot2.R

household <- read.table("household_power_consumption.txt", sep = ";") 
names(household) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
household$Date <- as.Date(household$Date, format="%d/%m/%Y")
#filtering by dates
household1 <- household[(household$Date == "2007-02-01") | (household$Date =="2007-02-02"),]

dates <- household1$Date
times <- household1$Time
X <- paste(dates, times)
dateantime <- strptime(X, "%Y-%m-%d %H:%M:%S")

household1$Global_active_power <- as.numeric(as.character(household1$Global_active_power))
         
plot(dateantime, household1$Global_active_power, type="l",xlab = "", ylab = "Global Active Power(kilowatts)")
dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off()





