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
  
  par(mfcol = c(2,2))
  #Plot - 1
  plot(ecdata$newdate,ecdata$Global_active_power, type="l", 
       ylab = "Global Active Power", xlab="")
  #Plot - 2
  plot(ecdata$newdate,ecdata$Sub_metering_1, type="l", 
       ylab = "Energy sub metering")
  points(ecdata$newdate,ecdata$Sub_metering_2, type="l", col = "red")
  points(ecdata$newdate,ecdata$Sub_metering_3, type="l", col = "blue")

  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
         lty=c(1,1), lwd=c(1.5, 1.5, 1.5),col=c("black", "red", "blue")) 
  #Plot- 3
  plot(ecdata$newdate,ecdata$Voltage, type="l", 
       ylab = "Voltage", xlab="datetime")
  
  # Plot - 4
  plot(ecdata$newdate,ecdata$Global_reactive_power, type="l", 
       ylab = "Global_reactive_power", xlab="datetime")
  
  # copy the plot1 to png devicel
  dev.copy(png, file = "plot4.png")
  # close the device
  dev.off()
  #reset par
  par(mfcol= c(1,1))
  gc(verbose = TRUE)
