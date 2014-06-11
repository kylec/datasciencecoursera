library(plyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", dest="data.zip", method="curl")
unzip("data.zip")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 3
# decrease emission: non-point, on-road, non-road
# increse emission: point
library(ggplot2)
d = NEI[NEI$fips=="24510",]
dd = ddply(d, .(year, type), summarise, Emissions=sum(Emissions))
p = ggplot(data=dd, aes(x=year, y=Emissions)) + geom_line(aes(colour=type))
ggsave("plot3.png", p)