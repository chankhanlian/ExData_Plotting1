# Create a line graph of the global active power data against time.
# Save the plot to a png file.

# Load data into allData
allData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE)

# Take data for between 2/1/2007 and 2/2/2007
subData<-allData[allData$Date=='1/2/2007' | allData$Date=='2/2/2007', ]

# Add a date/time column to the subdata
dateTime<-strptime(paste(subData[,1], subData[,2]), "%d/%m/%Y %H:%M:%S")
subData$dateTime<-dateTime

# Convert global_active_power to numeric
subData$Global_active_power<-as.numeric(as.character(subData$Global_active_power))

# Open a png file
png('plot2.png')

# Create line graph of global_active_power data with weekdays on x-axis
with(subData, plot(dateTime, Voltage, type="l", 
                   ylab="Voltage",
                   xlab="datetime"))

dev.off()
