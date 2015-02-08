#Read the data file into a dataframe
household<-read.table("household_power_consumption.txt",header=T,sep=";")

#Subsitute NA for ? and make the variable numeric
household$Global_active_power [household$Global_active_power == "?"] <- NA
household$Global_active_power <- as.numeric(household$Global_active_power)

#Build a subset dataframe for 2007-02-01 and 2007-02-02
mydateformat <-"%d/%m/%Y"
household$Date <-as.Date(household$Date,mydateformat)
householdsub <-subset(household,household$Date == "2007-02-01" | household$Date == "2007-02-02")

#Plot and save png
png(filename="plot1.png",width=480,height=480)
hist(householdsub$Global_active_power/500,xlab="Global Active Power (kilowatts)", col = "red", main="Global Active Power")
dev.off()