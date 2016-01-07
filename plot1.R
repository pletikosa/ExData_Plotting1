## Download and unzip the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

temp <- tempfile()
download.file(fileUrl,temp)
electricityData <- read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", dec=".", na.strings = "?")
unlink(temp)

## Select only those observations which belong to the time interval of interest (2007-02-01 to 2007-02-02):

## 1. select only date column to work on smaller data
dateColumn <- electricityData$Date
## convert the dateColumn into Date object for date manipulation
dateColumn <- as.Date(as.character(dateColumn), format="%e/%m/%Y")

## 2. define start and end dates that are of interest to us
startDate <- as.Date("2007-02-01")
endDate <- as.Date("2007-02-02")

## 3. create an index as logical vector that identifies only those observations which correspond to the dates of interest
index <- dateColumn == startDate | dateColumn == endDate

## 4. apply the index to the large dataset to get only the relevat data
electricityDataSmall <- electricityData[index,]

## 5. create a new column which contains the complete date and time information
electricityDataSmall$DateTime <- paste(as.character(electricityDataSmall$Date), as.character(electricityDataSmall$Time), sep =" ")
electricityDataSmall$DateTime <- strptime(electricityDataSmall$DateTime, format = "%e/%m/%Y %H:%M:%S")

## Plot the charts:

## plot1
png("plot1.png", width = 480, height = 480)
par(cex=1.0)
Sys.setlocale("LC_ALL","English")
hist(electricityDataSmall$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
