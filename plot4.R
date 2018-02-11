##Combine four plots onto a single plot

# Load data into allData
allData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE)

# Take data for between 2/1/2007 and 2/2/2007
subData<-allData[allData$Date=='1/2/2007' | allData$Date=='2/2/2007', ]

# Add a date/time column to the subdata
dateTime<-strptime(paste(subData[,1], subData[,2]), "%d/%m/%Y %H:%M:%S")
subData$dateTime<-dateTime

# Convert the global_active_power, sub_metering, voltage and global_reactive_power
# data to numeric
subData$Global_active_power<-as.numeric(as.character(subData$Global_active_power))
subData$Sub_metering_1<-as.numeric(as.character(subData$Sub_metering_1))
subData$Sub_metering_2<-as.numeric(as.character(subData$Sub_metering_2))
subData$Sub_metering_3<-as.numeric(as.character(subData$Sub_metering_3))
subData$Voltage<-as.numeric(as.character(subData$Voltage))
subData$Global_reactive_power<-as.numeric(as.character(subData$Global_reactive_power))

# Open png file
png('plot4.png')

# Set up a 2 by 2 grid
par(mfrow=c(2,2))

# Make four success plots
# 1 Upper left plot 
# Create line graph of global_active_power data with weekdays on x-axis
# and 'Global Active Power (kilowatts)' as y-axis label
with(subData, plot(dateTime, Global_active_power, type="l", 
                   ylab="Global Active Power (kilowatts)",
                   xlab=""))

# 2 Upper right plot 
# Create line graph of voltage data with weekdays on x-axis with label 'datetime'
# and 'Voltage' as y-axis label
with(subData, plot(dateTime, Voltage, type="l", 
                   ylab="Voltage",
                   xlab="datetime"))

# 3 Lower left plot 
# Overlay sub_metering_data onto same plot with a legend
# Plot the first sub_metering data
plot(subData$dateTime, subData$Sub_metering_1, type="l", 
                   ylab="Energy sub metering",
                   xlab="")

# Overlay the sub_metering_2 data to the plot, coloring the line red
lines(subData$dateTime, subData$Sub_metering_2, col="red")

# Overlay the sub_metering_3 data to the plot, coloring the line blue
lines(subData$dateTime, subData$Sub_metering_3, col="blue")

# Create a legend in the upper right corner, without a border
legend("topright", legend=(c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")),
                          col=c("black", "red", "blue"), lty=1, bty='n')

# 4 Lower right plot
# Create line graph of global_reactive_power with weekdays on x-axis
with(subData, plot(dateTime, Global_reactive_power, type="l", xlab="datetime"))

# Close the png file
dev.off()