
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis")

if (exists("powerData") == FALSE){
  powerData = read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), 
                         header=T, sep=";", stringsAsFactors = FALSE);
  powerData = subset(powerData, Date == "1/2/2007" | Date == "2/2/2007");
  powerData[, c(3:9)] <- sapply(powerData[, c(3:9)], as.numeric);
}

powerData$date_time = powerData$Time;
for (i in 1:nrow(powerData)){
  firstChar = substr(powerData$Date[i], 1, 1); 
  temp = paste("2007-02-0", firstChar, sep = "");
  powerData$date_time[i] = paste(temp, powerData$Time[i]);
}
powerData$date_time = as.POSIXct(powerData$date_time);


################

png("plot3.png", width = 480, height = 480)

plot(Sub_metering_1 ~ date_time, data = powerData, col = "green",  ylab = "Energy sub metering", xlab = "", ylim = c(0,30)  );
lines(Sub_metering_2 ~ date_time, data = powerData, col = "red", xlab = "", ylim = c(0,30));
lines(Sub_metering_3 ~ date_time, data = powerData, col = "blue", xlab = "", ylim = c(0,30));
legend("topright", lty=c(1,1), col = c("green", "red", "blue"), legend = columnNames[7:9])

dev.off();

