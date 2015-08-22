##Reading data from RDS
NEI = readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
SCC = readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")

##Baltimore data
data_Baltimore = NEI[NEI$fips == "24510",]

##Aggregate the emissions by year
aggTotalsBaltimore = aggregate(Emissions ~ year, data_Baltimore, sum)

##plot
png("plot2.png", width = 480, height = 480)

barplot((aggTotalsBaltimore$Emissions)/10^6, names.arg = aggTotalsBaltimore$year,
        xlab = "Year", ylab = "PM2.5 Emissions (10^6 Tonnes)",
        main = "Total PM2.5 Emissions from Baltimore City sources")
dev.off()