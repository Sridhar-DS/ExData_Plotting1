library(sqldf)

## The file is downloaded to working directory
## Read the file into a dataframe. Read the subset ( 1-Feb-2007 and 2-Feb-2007) only

df <- read.csv2.sql(file="household_power_consumption.txt", header=TRUE, sep=";",
                    sql = "select * from file where Date in ('1/2/2007','2/2/2007') ")

## Convert the char columns for date and time to proper formats

df$Date<-as.Date(as.character(df$Date),"%d/%m/%Y")

df$fulldate <- with(df, as.POSIXct(paste(df$Date, df$Time), format="%Y-%m-%d %H:%M:%S"))

######## Plot 3

png('plot3.png',width = 480, height = 480)

with(df, plot(fulldate, Sub_metering_1, type = "n", xlab="" ,ylab="Energy Sub metering"))
with(df, lines(fulldate, Sub_metering_1, col = "black"))
with(df, lines(fulldate, Sub_metering_2, col = "red"))
with(df, lines(fulldate, Sub_metering_3, col = "blue"))

legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(2.5,2.5),col=c("black","red","blue"))

dev.off()

closeAllConnections()

