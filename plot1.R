##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Aggregate the emissions by year
aggTotals = aggregate(Emissions ~ year, NEI, sum)

##plot
png("plot1.png", width = 480, height = 480)

barplot((aggTotals$Emissions)/10^6, names.arg = aggTotals$year,
        xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tonnes)",
        main = "Total PM2.5 Emissions from all US sources")
dev.off