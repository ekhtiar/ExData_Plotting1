#first we read  the entire dataset and store it in pwdata, we are using sep=";" as data is seperated by ;
pwdata <- read.table(file="./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
#the data is cleaned a little by converting date character to date object
pwdata$Date <- as.Date(pwdata$Date, "%d/%m/20%y")
#the data is subsetted to the just the days we want to analyse
selpwdata <- subset(pwdata, (pwdata$Date >= as.Date("2007-02-01")) &(pwdata$Date <= as.Date("2007-02-02")))
#date and time is joined together in the Time column so the entire column can be converted into a timestamp
selpwdata$Time <- paste (selpwdata$Date, selpwdata$Time, sep = " ")
#conversion of the Time column to a date time object 
selpwdata$Time <- strptime(selpwdata$Time, "%Y-%m-%d %H:%M:%S")
#defining the png output
png(filename = "./Plot2.png", width=480, height=480)
#plot function is used to create the grid, pch= " " is used as we want to generate line grapth without points in the next step
plot(selpwdata$Time, selpwdata$Global_active_power, pch=" ", xlab = "Days",ylab="Global active power (kilowatts)")
#generating line graph for Global_active_power
lines(selpwdata$Time, selpwdata$Global_active_power)
#mandatory housekeeping
dev.off()