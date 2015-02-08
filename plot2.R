#Read the data file into a dataframe
household<-read.table("household_power_consumption.txt",header=T,sep=";")

#Subsitute NA for ? and make the variable numeric
household$Global_active_power [household$Global_active_power == "?"] <- NA
household$Global_active_power <- as.numeric(household$Global_active_power)

#Build a subset dataframe for 2007-02-01 and 2007-02-02
mydateformat <-"%d/%m/%Y"
household$Date <-as.Date(household$Date,mydateformat)
householdsub <-subset(household,household$Date == "2007-02-01" | household$Date == "2007-02-02")

#Build a new variable with date and timestamp concatenated
householdsub$Timestamp <-paste(householdsub$Date,householdsub$Time, sep=" ")
householdsub$Timestamp <- as.POSIXct(householdsub$Timestamp,format="%Y-%m-%d %H:%M:%S")

#Plot and save png
png(filename="plot2.png",width=480,height=480)
plot(householdsub$Timestamp,householdsub$Global_active_power/500,  type="l", lty=1, ylab="Global Active Power (kilowatts)",xlab = "")
dev.off()