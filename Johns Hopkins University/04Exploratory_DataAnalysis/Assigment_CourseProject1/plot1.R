#plot1.R

household <- read.table("household_power_consumption.txt", sep = ";") 
names(household) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

household$Date <- as.Date(household$Date, format="%d/%m/%Y")

household1 <- household[(household$Date == "2007-02-01") | (household$Date =="2007-02-02"),]

household1$Global_active_power <- as.numeric(as.character(household1$Global_active_power))

hist(household1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
dev.copy(png, file = "plot1.png", width=480, height=480) 
dev.off()

