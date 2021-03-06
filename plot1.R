plot1 <- function() {

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
    png(filename="plot1.png", width = 480, height = 480, type="cairo")
    
    ## Plot histogram
    hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
    
    ## Close png device
    dev.off()
}