library(data.table)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", dest="data.zip", method="curl")
unzip("data.zip", overwrite=T)
data <- fread("household_power_consumption.txt")
d = data[which(data$Date=="1/2/2007" | data$Date=="2/2/2007"), ]

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
z=strptime(paste(d$Date, d$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

# subplot1
plot(z, d$Global_active_power, type="s", ylab="Global Active Power (Kilowatts)", xlab="")

# subplot2
plot(z, d$Voltage, type="s", ylab="Voltage", xlab="datetime" )

# subplot3
y_max = max(as.numeric(c(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3)))
plot(z, d$Sub_metering_1, type="s", ylab="Energy sub metering", col="black", xlab="", ylim=c(0,y_max))
par(new=T)
plot(z, d$Sub_metering_2, type="s", ylab="Energy sub metering", col="red", xlab="", ylim=c(0,y_max))
par(new=T)
plot(z, d$Sub_metering_3, type="s", ylab="Energy sub metering", col="blue", xlab="", ylim=c(0,y_max))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1,1), col=c("black", "red","blue"))
par(new=F)

#subplot4
plot(z, d$Global_reactive_power, type="s", ylab="Global_reactive_power", xlab="datetime")
dev.off()


