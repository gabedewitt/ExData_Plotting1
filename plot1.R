# Script is initiated checking if the Dataset zip file is present
# If it is, it will set the working directory to it and begin the analysis
# If it is not, it will assume that the current directory is the Dataset one
if (!file.exists("exdata_data_household_power_consumption.zip")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL,"exdata_data_household_power_consumption.zip", method="curl")
}
if (!file.exists("household_power_consumption.txt")) { 
        unzip("exdata_data_household_power_consumption.zip") 
}

power_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE ,skip=grep("2007-02-01", readLines("household_power_consumption.txt")), nrows=2880)

