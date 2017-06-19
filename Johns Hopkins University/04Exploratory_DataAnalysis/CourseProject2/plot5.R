
# Plot 5

"How have emissions from motor vehicle sources changed 
from 1999-2008 in Baltimore City?"

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Filter by Baltimore City
NEI.Baltimore <- subset(NEI, fips == "24510") 

#Filter by motor vehicle sources in Baltimore City
motveh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehiclesSCC <- SCC[motveh,]$SCC
NEI.Baltimore.Vehic <- NEI.Baltimore[NEI.Baltimore$SCC %in% vehiclesSCC,]

years <- as.numeric(c("1999", "2002", "2005", "2008"))

# total PM2.5 emission from all motor vehicle sources for each year
#totalbyYear <- with(NEI.Baltimore.Vehic, tapply(Emissions, year, sum, na.rm=T))

library(ggplot2)
png("plot5.png", width = 480, height = 480)

g <- ggplot(NEI.Baltimore.Vehic,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(g)

dev.off()