##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Subset coal combustion related NEI data
combustionRelated = grepl("comb", SCC$SCC.Level.One, ignore.case = TRUE)
coalRelated = grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
coalCombustion = (combustionRelated & coalRelated)
combustionSCC = SCC[coalCombustion,]$SCC 
combustionNEI = NEI[NEI$SCC %in% combustionSCC, ]

##plot
png("./plot4.png", width = 640, height = 480)

library(ggplot2)

g <- ggplot(combustionNEI, aes(factor(year), Emissions/10^5))
p <- g + geom_bar(stat = "identity", fill="grey", width=0.7) +
  theme_bw() + guides(fill=FALSE) +
  xlab("year") +
  ylab("Total PM2.5 Emssions (10^5 Tons)") +
  ggtitle("Total PM2.5 Coal Combustion Source Emissions Across US from 1999 to 2008")

print(p)
dev.off