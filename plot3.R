library(dplyr)

power.data<-read.delim('household_power_consumption.txt',header=TRUE,sep=";",colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings = "?")##Read Data
power.data<-mutate(power.data,Date_Time=paste(Date,Time)) #Create a new variable by combining data and time
power.data<-mutate(power.data,Date=as.Date(Date,"%d/%m/%Y"))#change to date class
power.data$DateTime<-strptime(power.data$Date_Time,"%d/%m/%Y %H:%M:%S")#change to time class
start.date<-as.Date("01/02/2007","%d/%m/%Y")#assign the starting date
end.date<-as.Date("02/02/2007","%d/%m/%Y")#assign the end date
power.data<-power.data[power.data$Date>=start.date&power.data$Date<=end.date,]#filter the data between start and end dates
png(filename='plot3.png',width=480,height = 480,units = "px")##Open a PNG device; create 'plot1.png' in the working directory with size = 480 X 480 pixels
plot(power.data$DateTime,power.data$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
points(power.data$DateTime,power.data$Sub_metering_2,type="l",col="red")
points(power.data$DateTime,power.data$Sub_metering_3,type="l",col="blue")
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()#close the png device