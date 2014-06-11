library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="data.zip", method="curl")
unzip("data.zip", overwrite=T)
data <- fread("household_power_consumption.txt")
d = data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# plot 1
png("plot1.png", width=480, height=480)
hist(as.numeric(d$Global_active_power), main="Global Active Power", col="red", xlab="Global Active Power (Kilowatts)")
dev.off()