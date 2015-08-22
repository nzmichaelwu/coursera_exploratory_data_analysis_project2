##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Subset vehicle related NEI data for Baltimore
vehicle = grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicleSCC = SCC[vehicle,]$SCC
vehicleNEI = NEI[NEI$SCC %in% vehicleSCC, ]

baltimoreVehicleNEI = vehicleNEI[vehicleNEI$fips == "24510", ]
baltimoreVehicleNEI$city = "Baltimore"

##Subset vehicle related NEI data for LA
LAVehicleNEI = vehicleNEI[vehicleNEI$fips == "06037", ]
LAVehicleNEI$city = "Los Angeles"

##Combine two subsets
bothNEI = rbind(baltimoreVehicleNEI, LAVehicleNEI)

##plot
png("./plot6.png", width = 640, height = 480)

library(ggplot2)

g <- ggplot(bothNEI, aes(x = factor(year), y = Emissions, fill=city))
p <- g + geom_bar(stat = "identity", aes(fill=city)) +
  facet_grid(.~city, scales = "free", space = "free") +
  theme_bw() + guides(fill=FALSE) +
  xlab("year") +
  ylab("Total PM2.5 Emssions (Tons)") +
  ggtitle("Total PM2.5 Motor Vehicle Source Emissions in Baltimore & LA from 1999 to 2008")

print(p)
dev.off