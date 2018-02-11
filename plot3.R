# Plot the three sub metering data readings onto the same plot.
# Save to plot3.png file

# Load data into allData
allData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE)

# Take data for between 2/1/2007 and 2/2/2007
subData<-allData[allData$Date=='1/2/2007' | allData$Date=='2/2/2007', ]

# Add a date/time column to the subdata
dateTime<-strptime(paste(subData[,1], subData[,2]), "%d/%m/%Y %H:%M:%S")
subData$dateTime<-dateTime

# Convert the sub_metering data to numeric
subData$Sub_metering_1<-as.numeric(as.character(subData$Sub_metering_1))
subData$Sub_metering_2<-as.numeric(as.character(subData$Sub_metering_2))
subData$Sub_metering_3<-as.numeric(as.character(subData$Sub_metering_3))

# Open the png file
png('plot3.png')

# Plot the first sub_metering data
plot(subData$dateTime, subData$Sub_metering_1, type="l", 
                   ylab="Global Active Power (kilowatts)",
                   xlab="")

# Overlay the sub_metering_2 data to the plot, coloring the line red
lines(subData$dateTime, subData$Sub_metering_2, col="red")

# Overlay the sub_metering_3 data to the plot, coloring the line blue
lines(subData$dateTime, subData$Sub_metering_3, col="blue")

# Create a legend in the upper right corner
legend("topright", legend=(c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")),
                          col=c("black", "red", "blue"), lty=1)

# Close the png file
dev.off()