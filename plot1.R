# Create a histogram of the global active power consumption and 
# save plot to plot1.png

#Load data into allData
allData<-read.csv("household_power_consumption.txt", sep=";", header=TRUE)

#Take data for between 2/1/2007 and 2/2/2007
subData<-allData[allData$Date=='1/2/2007' | allData$Date=='2/2/2007', ]

#Add a date/time column to the subdata
dateTime<-strptime(paste(subData[,1], subData[,2]), "%d/%m/%Y %H:%M:%S")
subData$dateTime<-dateTime

#Convert global_active_power to numeric
subData$Global_active_power<-as.numeric(as.character(subData$Global_active_power))

# Open a png file
png('plot1.png')

# Create histogram for global_active_power consumption
with(subData, hist(Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     col="red",
     xlim=c(0, 6),
     ylim=c(0, 1200),
     breaks=12, 
     axes=FALSE))

#A djust x- and y-axes
axis(side=1, at=c(0, 2, 4, 6))
axis(side=2, at=c(0, 200, 400, 600, 800, 1000, 1200))

# Close png file
dev.off()