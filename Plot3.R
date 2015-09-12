#first we read  the entire dataset and store it in pwdata, we are using sep=";" as data is seperated by ;
pwdata <- read.csv(file="./data/household_power_consumption.txt", header = TRUE, sep = ";", as.is = TRUE)
#the data is cleaned a little by converting date character to date object
pwdata$Date <- as.Date(pwdata$Date, "%d/%m/20%y")
#the data is subsetted to the just the days we want to analyse
selpwdata <- subset(pwdata, (pwdata$Date >= as.Date("2007-02-01")) &(pwdata$Date <= as.Date("2007-02-02")))
#date and time is joined together in the Time column so the entire column can be converted into a timestamp
selpwdata$Time <- paste (selpwdata$Date, selpwdata$Time, sep = " ")
#conversion of the Time column to a date time object 
selpwdata$Time <- strptime(selpwdata$Time, "%Y-%m-%d %H:%M:%S")
#defining the png output
png(filename = "./Plot3.png", width=480, height=480)
#first the plot function is used to create the grid, pch= " " is used as we want to generate line grapth without points in the next step
plot(selpwdata$Time, selpwdata$Sub_metering_1, pch=" ", xlab = "Days",ylab="Energy sub metering")
#generating line graph for Sub_metering_1 with color as blue
lines(selpwdata$Time, selpwdata$Sub_metering_1, col="blue")
#generating line graph for Sub_metering_2 with color as red
lines(selpwdata$Time, selpwdata$Sub_metering_2, col="red")
#generating line graph for Sub_metering_3 with color as green
lines(selpwdata$Time, selpwdata$Sub_metering_3, col="green")
#creating the legend
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), fill=c("blue","red", "green"))
#mandatory housekeeping
dev.off()