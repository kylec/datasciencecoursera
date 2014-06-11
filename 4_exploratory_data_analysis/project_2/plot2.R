library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 2
# emission decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008
d = NEI[NEI$fips=="24510",]
dd = ddply(d, .(year), summarise, Emissions=sum(Emissions))
png("plot2.png")
plot(dd[,1], dd[,2], ylab="Baltimore city total emission in tons", xlab="Years", xaxt='n')
axis(1, at=dd[,1])
dev.off()
