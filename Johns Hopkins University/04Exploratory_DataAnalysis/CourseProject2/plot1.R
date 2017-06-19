
#Plot1

"Have total emissions from PM2.5 decreased in the United States 
from 1999 to 2008? Using the base plotting system, make a plot 
showing the total PM2.5 emission from all sources for each of 
the years 1999, 2002, 2005, and 2008."

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

years <- as.numeric(c("1999", "2002", "2005", "2008"))

# total PM2.5 emission from all sources for each years
totalbyYear <- with(NEI, tapply(Emissions, year, sum, na.rm=T))

options(scipen = 5) # to format the values in ylabel.
plot(years, totalbyYear, main="Total emissions from 1999-2008", type="b",xlab = "Year", ylab = "Total PM2.5")
dev.copy(png, file = "plot1.png", width=480, height=480) 
dev.off()
