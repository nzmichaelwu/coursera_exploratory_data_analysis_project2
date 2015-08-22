##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Subset vehicle related NEI data
vehicle = grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC = SCC[vehicle,]$SCC
vehicleNEI = NEI[NEI$SCC %in% vehicleSCC, ]

baltimoreVehicleNEI = vehicleNEI[vehicleNEI$fips == "24510", ]

##plot
png("./plot5.png", width = 640, height = 480)

library(ggplot2)

g <- ggplot(baltimoreVehicleNEI, aes(factor(year), Emissions))
p <- g + geom_bar(stat = "identity", fill="grey", width=0.7) +
  theme_bw() + guides(fill=FALSE) +
  xlab("year") +
  ylab("Total PM2.5 Emssions (Tons)") +
  ggtitle("Total PM2.5 Motor Vehicle Source Emissions in Baltimore from 1999 to 2008")

print(p)
dev.off