library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 4 coal combustion resources
# code for coal combustion sources
codes = SCC[grep("Coal",SCC$EI.Sector), ]$SCC
d = NEI[NEI$SCC %in% codes,] 
dd=ddply(d, .(year), summarise, sum(Emissions))
png("plot4.png")
plot(dd[,1], dd[,2], ylab="coal emission in tons", xlab="Years", xaxt='n')
axis(1, at=dd[,1])
dev.off()
