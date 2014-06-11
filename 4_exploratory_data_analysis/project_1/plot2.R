library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="data.zip", method="curl")
unzip("data.zip", overwrite=T)
data <- fread("household_power_consumption.txt")
d = data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

# plot 2
png("plot2.png", width=480, height=480)
z=strptime(paste(d$Date, d$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
plot(z, d$Global_active_power, type="s", ylab="Global Active Power (Kilowatts)", xlab="")
dev.off()
