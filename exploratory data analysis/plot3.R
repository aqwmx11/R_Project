#download and unzip data
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="project1.zip")
unzip("project1.zip")

#read data into R
files<-file("household_power_consumption.txt")
data<-read.table(text = grep("^[1,2]/2/2007",readLines(files),value=TRUE), sep = ';', col.names = c("Date", "Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')

#open the dev (Note: the default width and height in the png function is 480px.)
png(filename="plot3.png")

#convert the format, set the language to English and plot
datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Sys.setlocale(category = "LC_ALL", locale = "english")
plot(datetime, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(datetime, data$Sub_metering_2, col = 'red')
lines(datetime, data$Sub_metering_3, col = 'blue')
legend('topright', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), lwd = 1)

# close device
dev.off()