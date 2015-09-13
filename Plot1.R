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
#change Global Active Power to numeric
selpwdata$Global_active_power <- as.numeric(selpwdata$Global_active_power)
#defining the png output
png(filename = "./Plot1.png", width=480, height=480)
#plot the histogram
hist(selpwdata$Global_active_power, breaks = 12, col = "red", xlim =c(0,6), ylim = c(0,1200), main = "Global Active Power", ylab = "Frequency", xlab = "Global Active Power (kilowatt)")
#mandatory housekeeping
dev.off()