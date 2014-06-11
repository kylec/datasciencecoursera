library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 5 
# codes for vehicle
codes = SCC[grep("Vehicle", SCC$SCC.Level.Two), ]$SCC
d = NEI[NEI$SCC %in% codes,]
d = d[d$fips=="24510", ]
dd=ddply(d, .(year), summarise, sum(Emissions))
png("plot5.png")
plot(dd[,1], dd[,2], ylab="Baltimore's vehicle emission in tons", xlab="Years", xaxt='n')
axis(1, at=dd[,1])
dev.off()
