##Reading the PARt of the dataset containing required data range
file_con<-file("household_power_consumption.txt")
open(file_con)
dat<- read.table(file_con, sep=";", 
                 header=TRUE,  nrow=75000, colClasses="character")
close(file_con)
##dat_1 <- lapply(dat[1:10000,1:9], function(x) { gsub("? ", "NA", x)})
##Formatting the dat aand time
dat_date<-paste(as.Date(dat[,1], format="%d/%m/%Y"), dat[,2], sep=" ")
dat_time<-strptime(dat_date, format="%Y-%m-%d %H:%M:%S",tz="")
##subsetting the dataset to the EXACT date/time range
dat_x<-dat[dat_time>="2007-02-01 00:00:00"& dat_time<="2007-02-02 23:59:00",]
day_time<-dat_time[dat_time>="2007-02-01 00:00:00"& dat_time<="2007-02-02 23:59:00"]

## Generating plot 4
png(file="plot4.png",  width = 480, height = 480, units = "px")
par(mfrow= c(2,2))

## Generating plot 4.1

with(dat_x, {plot(day_time, Global_active_power, type="l", xlab="", 
                  ylab= "Global Active Power (kilowatts)")})
## Generating plot 4.2
with(dat_x, plot(day_time, Voltage, type="l", xlab="datetime"))
## Generating plot 4.3
with(dat_x, {plot(day_time, Sub_metering_1, type="n", xlab="", 
                  ylab= "Energy sub metering")
        lines(day_time, Sub_metering_1)
        lines(day_time, Sub_metering_2, col="red")
        lines(day_time, Sub_metering_3, col="blue")
        legend("topright", lwd=2, col=c("black", "red","blue"), 
               legend=c("Energy sub_metering_2","Energy sub_metering_1",
                        "Energy sub_ metering_3"),cex=0.75)
})
## Generating plot 4.4
with(dat_x, plot(day_time, Global_reactive_power, 
                 type="l", xlab="datetime"))

dev.off()

