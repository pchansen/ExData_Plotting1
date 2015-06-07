plot4 <- function() {

    ## Only read into memory data that is needed (i.e. dates 2007-02-01 and 2007-02-02)
    filename <- "household_power_consumption.txt"
    
    ## Get header information
    header <- read.table(filename, header = FALSE, sep =';', nrows=1, stringsAsFactors = FALSE)
    
    ## Text file is already sorted by data and time. Day 2007-02-01 starts on row 66638 so skip 66637 rows
    ## There are 2880 rows covering the relevant 2 days so read in only these rows.
    data <- read.table(filename, header=FALSE, sep=";", skip=66637, nrows=2880, na.strings="?")
    
    ## Assign header names back to the reduced data set
    names(data) <- unlist(header)
    
    ## Convert the Date and Time variables to Date/Time classes in R
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    data$Time <- strptime((paste(data$Date,data$Time)),"%Y-%m-%d %H:%M:%S")
    
    ## Open png plotting device
    png(filename="plot4.png", width = 480, height = 480, type="cairo")
    
    ## Set up plotting for 2x2 layout
    par(mfrow=c(2,2))
    
    ## Plot 1, top left
    plot(data$Time,data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    ## Plot 2, top right
    plot(data$Time,data$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    ## Plot 3, bottom left
    plot(data$Time,data$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(data$Time, data$Sub_metering_1)
    lines(data$Time, data$Sub_metering_2, col="red")
    lines(data$Time, data$Sub_metering_3, col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")
        
    ## Plot 4, bottom right    
    plot(data$Time,data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
    
    ## Close png device
    dev.off()
}