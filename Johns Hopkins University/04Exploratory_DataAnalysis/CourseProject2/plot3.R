
#Plot 3

"Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
variable, which of these four sources have seen decreases in emissions from 1999-2008
for Baltimore City? Which have seen increases in emissions from 1999-2008? Use 
the ggplot2 plotting system to make a plot answer this question."

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI.Baltimore <- subset(NEI, fips == "24510", select=c(Emissions, type, year)) 

years <- as.numeric(c("1999", "2002", "2005", "2008"))

typ <- unique(as.factor(NEI.Baltimore$type))
output <- matrix()
c1 <- numeric()
c2 <- numeric()
c3 <- factor()

for (i in seq_along(typ))
{
    NEI.typI <- subset(NEI.Baltimore, type == typ[i], select=c(Emissions, year)) 
    totalbyYear <- with(NEI.typI, tapply(Emissions, year, sum, na.rm=T))
    ctype <- rep(as.character(typ[i]),4)    
    
    c1 <- append(c1, totalbyYear)
    c2 <- append(c2, years)
    c3 <- append(c3, ctype)  
    
}

output <-cbind(c1, c2, c3)     

dfr.toplot <- data.frame(output)
colnames(dfr.toplot) <- c("total","year","type")


# I just have a detail here with the order o y-axis
# but it's possible to understand the graphic
png("plotventas.png", width = 480, height = 480)

g <- ggplot(dfr.toplot, aes(x=year, y=total, colour=type)) +     
    geom_point()+
    labs(x="Year", y=expression("Total PM2.5"))+
    geom_line(aes(group=type))

print(g)

dev.off()

# Read RDS Files NEI <- readRDS("summarySCC_PM25.rds") SCC <- readRDS("Source_Classification_Code.rds") library(dplyr) library(ggplot2) ## Plot 3 png(file = "plot3.png", width=800, height = 450) NEI_SUB <- filter(NEI, fips == "24510") totalPMYearType <- aggregate(Emissions ~ year + type, NEI_SUB, sum) qplot(year, Emissions, data=totalPMYearType, color=type, geom="line") + ggtitle("Total emissions of PM2.5 in the Baltimore City, Maryland by Source Type and Year") + xlab("Year") + ylab("Emissions (thousands of tons)") dev.off()


