# Install packages
library(data.table)
library(dplyr)
library(lubridate)
# Set the directory path
getwd()
setwd("E:\\Coursera\\Exploratory Data Analysis\\Week-1\\")
dst1 = "./data/household_power_consumption.txt"
startdata <- fread(dst1, header= TRUE,nrow=2)
skiprows <- grep("1/2/2007;00:00:00", readLines(dst1))
nrows <- length(grep("^[1-2]/2/2007", readLines(dst1)))
# Read data for 1 month from 2007-02-01 and 2007-02-02
ecdata <- fread(dst1, skip=skiprows[[1]]-1, nrow= nrows)
names(ecdata) <- names(startdata)
head(ecdata)
str(ecdata)
summary(ecdata)
# Convert Date and Time from Char to Date and Time format
ecdata$Date <- dmy(ecdata$Date) # Convert date column to Date field
ecdata$newdate <- paste(ecdata$Date, ecdata$Time)
ecdata$newdate <- as.POSIXct(ecdata$newdate , format="%Y-%m-%d %H:%M")

## open the default screen device on this platform if no device is open
if(dev.cur() == 1) dev.new()
# Scatterplot
plot(ecdata$newdate,ecdata$Global_active_power, type="l", 
     ylab = "Global Active Power (kilowatts)", xlab="")
# copy the plot1 to png device
dev.copy(png, file = "plot2.png")
# close the device
dev.off()
gc(verbose = TRUE)
