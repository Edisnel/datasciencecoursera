
#Plot 4

"Across the United States, how have emissions from coal 
combustion-related sources changed from 1999-2008?."

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsettin coal combgustion related NEI data
comb1 <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
comb2 <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (comb1 & comb2)
combustionSCC <- SCC[coalCombustion,]$SCC

NEI.Comb <- NEI[NEI$SCC %in% combustionSCC, ]

years <- as.numeric(c("1999", "2002", "2005", "2008"))

# total PM2.5 emission from all sources for each years
totalbyYear <- with(NEI.Comb, tapply(Emissions, year, sum, na.rm=T))

options(scipen = 5) # to format the values in ylabel.
plot(years, totalbyYear, main="Coal Combustion Source Emissions(1999-2008)",type="b",xlab = "Year", ylab = "Total PM[2.5] Emission")
dev.copy(png, file = "plot4.png", width=480, height=480) 
dev.off()
