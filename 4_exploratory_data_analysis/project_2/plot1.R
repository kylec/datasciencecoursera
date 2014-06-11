library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#plot 1 total emssion ~ years
png("plot1.png")
d = ddply(NEI, .(year), summarise, sum(Emissions))
plot(d[,1], d[,2], ylab="Total emission in tons", xlab="Years", xaxt='n')
axis(1, at=d[,1])
dev.off()