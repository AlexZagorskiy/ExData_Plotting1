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

 


## Generating plot 2
png(file="plot2.png",  width = 480, height = 480, units = "px")
with(dat_x, {plot(day_time, Global_active_power, type="l", xlab="", 
             ylab= "Global Active Power (kilowatts)")})
dev.off()


