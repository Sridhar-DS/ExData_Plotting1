library(sqldf)

## The file is downloaded to working directory
## Read the file into a dataframe. Read the subset ( 1-Feb-2007 and 2-Feb-2007) only

df <- read.csv2.sql(file="household_power_consumption.txt", header=TRUE, sep=";",
                    sql = "select * from file where Date in ('1/2/2007','2/2/2007') ")

## Convert the char columns for date and time to proper formats

df$Date<-as.Date(as.character(df$Date),"%d/%m/%Y")

df$fulldate <- with(df, as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S"))

######## Plot 2

png('plot2.png',width = 480, height = 480)

plot(df$fulldate,df$Global_active_power,type="l",xlab="",ylab="Global Active Power (Kilowatts)")

dev.off()

closeAllConnections()

