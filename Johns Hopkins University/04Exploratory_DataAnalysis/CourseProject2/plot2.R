
#Plot 2

"Have total emissions from PM2.5 decreased in the 
Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
Use the base plotting system to make a plot answering this question."

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.Baltimore <- subset(NEI, fips == "24510", select=c(Emissions, year)) 

years <- as.numeric(c("1999", "2002", "2005", "2008"))

# total PM2.5 emission from all sources for each years
totalbyYear <- with(NEI.Baltimore, tapply(Emissions, year, sum, na.rm=T))

options(scipen = 5) # to format the values in ylabel.
plot(years, totalbyYear, main="Total emissions at Baltimore",type="b",xlab = "Year", ylab = "Total PM2.5")
dev.copy(png, file = "plot2.png", width=480, height=480) 
dev.off()
