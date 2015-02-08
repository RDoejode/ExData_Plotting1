#Read the data file into a dataframe
household<-read.table("household_power_consumption.txt",header=T,sep=";")

#Subsitute NA for ? and make the variables numeric
household$Sub_metering_1 [household$Sub_metering_1 == "?"] <-NA
household$Sub_metering_1 <- as.numeric(household$Sub_metering_1)

household$Sub_metering_2 [household$Sub_metering_2 == "?"] <-NA
household$Sub_metering_2 <- as.numeric(household$Sub_metering_2)

household$Sub_metering_3 [household$Sub_metering_3 == "?"] <-NA
household$Sub_metering_3 <- as.numeric(household$Sub_metering_3)

#Build a subset dataframe for 2007-02-01 and 2007-02-02
mydateformat <-"%d/%m/%Y"
household$Date <-as.Date(household$Date,mydateformat)
householdsub <-subset(household,household$Date == "2007-02-01" | household$Date == "2007-02-02")

#Build a new variable with date and timestamp concatenated
householdsub$Timestamp <-paste(householdsub$Date,householdsub$Time, sep=" ")
householdsub$Timestamp <- as.POSIXct(householdsub$Timestamp,format="%Y-%m-%d %H:%M:%S")

#Plot and save png
png(filename="plot3.png",width=480,height=480)
plot(householdsub$Timestamp,householdsub$Sub_metering_1, type="l", lty=1, col="black", xlab="", ylab="Energy Sub metering")
lines(householdsub$Timestamp,householdsub$Sub_metering_2/5, type="l", lty=1, col="red")
lines(householdsub$Timestamp,householdsub$Sub_metering_3, type="l", lty=1, col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()
