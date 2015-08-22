##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Baltimore data
data_Baltimore = NEI[NEI$fips == "24510",]

##Aggregate the emissions by year
aggTotalsBaltimoreByYearType = aggregate(Emissions ~ year + type, data_Baltimore, sum)

##plot
png("plot3.png", width = 640, height = 480)

library(ggplot2)

g <- ggplot(aggTotalsBaltimoreByYearType, aes(factor(year), Emissions,fill=type))
p <- g + geom_bar(stat = "identity", fill=.~type) +
  facet_grid(.~type, scales = "free", space = "free") +
  xlab("year") +
  ylab("Total PM2.5 Emssions (Tons)") +
  ggtitle("Total Emissions in Baltimore City, from 1999 to 2008 by Source Type")

print(p)
dev.off