## Source data URL
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Check if source data already exists else download
if(!file.exists("./data")){ dir.create("./data") }
if(!file.exists("./data/exdata_data_household_power_consumption.zip")){ download.file(fileURL,"./data/exdata_data_household_power_consumption.zip") }

## Change WD to ./data
setwd("./data")

## Getting complete dataset
data_orig <- read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_orig$Date <- as.Date(data_orig$Date, format="%d/%m/%Y")

## Subsetting the data, releasing memory back
data <- subset(data_orig, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(data_orig)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plot graph 2
plot(data$Global_active_power~data$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()