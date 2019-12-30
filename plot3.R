# Script is initiated checking if the Dataset zip file is present
# If it is, it will set the working directory to it and begin the analysis
# If it is not, it will assume that the current directory is the Dataset one

Sys.setlocale("LC_TIME", "C")

if(!require("lubridate")) install.packages("lubridate")
library("lubridate")

if (!file.exists("exdata_data_household_power_consumption.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,"exdata_data_household_power_consumption.zip", method="curl")
}

if (!file.exists("household_power_consumption.txt")) { 
        unzip("exdata_data_household_power_consumption.zip") 
}

if(!exists("power_data")){
        power_data <- read.table("household_power_consumption.txt", sep = ";", header = FALSE ,skip=(grep("^1/2/2007", readLines("household_power_consumption.txt"))[1]-1), nrows=2880)
        
        colnames(power_data) <- unlist(strsplit(readLines("household_power_consumption.txt")[1], split = ";"))
        
        power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
        
        power_data$Date <- as.Date(power_data$Date, "%d/%m/%Y")
        
        power_data$Time <- format(strptime(power_data$Time, format="%H:%M:%S"), format = "%H:%M:%S")
        
        power_data$datetime <- with(power_data, ymd(Date) + hms(Time))
}

png(filename = "plot3.png",  width = 480, height = 480)
with(power_data, plot(datetime, Sub_metering_1, type = "n",ylab = "Energy Sub metering", xlab= ""))
with(power_data, lines(datetime, Sub_metering_1, col = "black"))
with(power_data, lines(datetime, Sub_metering_2, col = "red"))
with(power_data, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty=1)
dev.off()
