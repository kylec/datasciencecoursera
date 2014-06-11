library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 6
library(ggplot2)
cities = data.frame(fips=c("24510", "06037"), name=c("Baltimore City", "Los Angeles County"))
codes = SCC[grep("Vehicle", SCC$SCC.Level.Two), ]$SCC
d = NEI[NEI$SCC %in% codes,]
d = d[which(d$fips %in% c("24510", "06037")), ]
dd=ddply(d, .(year, fips), summarise, Emissions=sum(Emissions))
dd=merge(dd, cities, by="fips")
p = ggplot(data=dd, aes(x=year, y=Emissions)) + geom_line(aes(colour=name))
ggsave("plot6.png", p)