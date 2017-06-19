
# Plot 6

"Compare emissions from motor vehicle sources in Baltimore City 
with emissions from motor vehicle sources in Los Angeles County, 
California (fips == "06037"). Which city has seen greater changes 
over time in motor vehicle emissions?"

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by Baltimore City
NEI.Baltimore <- subset(NEI, fips == "24510") 
NEI.Angeles <- subset(NEI, fips == "06037") 

#Filter by motor vehicle sources in Baltimore City and Los Angeles
motveh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[motveh,]$SCC

NEI.Baltimore.Vehic <- NEI.Baltimore[NEI.Baltimore$SCC %in% vehiclesSCC,]
NEI.Angeles.Vehic <- NEI.Baltimore[NEI.Angeles$SCC %in% vehiclesSCC,]

years <- c("1999", "2002", "2005", "2008")

totalbyYearBalt <- with(NEI.Baltimore.Vehic, tapply(Emissions, year, sum, na.rm=T))
totalbyYearAngel <- with(NEI.Angeles.Vehic, tapply(Emissions, year, sum, na.rm=T))
subset <- t(data.frame(totalbyYearBalt, totalbyYearAngel))

png("plot6.png", width = 480, height = 480)

barplot(subset, names.arg=years, beside=TRUE, col=c("grey","brown"), 
        ylab = "Total PM2.5", xlab ="Year",
        main="Emissions from motor vehicle in Baltimore and Los Angeles")
#legend("topright", c("grey","brown"), c("Baltimore", "Los Angeles"), lty=c(1,4), lwd=c(1,1))

legend("topright", legend = c("Baltimore", "Los Angeles"), fill = c("grey","brown"))

dev.off()