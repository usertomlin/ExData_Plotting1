
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis")
library("iterators");

lines <- ireadLines(file.path("household_power_consumption.txt") );
columnNames = nextElem(lines);
columnNames = strsplit(columnNames, split = ";")[[1]]

data = data.frame(matrix("", 10000, 9) , stringsAsFactors = FALSE);
colnames(data) = columnNames;

data$date_time = data$Time;

rowCount = 0;
for (i in 1: 100000){
  line = nextElem(lines);
  elements = strsplit(line, split = ";")[[1]]
  date = elements[1];
  
  if (date == "2/1/2007" | date == "2/2/2007"){
    rowCount = rowCount + 1;
    data[rowCount, 1:9] = elements;
    thirdChar = substr(date, 3,3);
    data[rowCount, 1] = paste("2007-02-0", thirdChar, sep = "");
    data[rowCount, 10] = paste(data[rowCount, 1], data[rowCount, 2]);
  }
}


data = data[1:rowCount, ];
data$date_time = as.POSIXct(data$date_time);

################


png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2));

plot(Global_active_power ~ date_time, data = data, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "");

plot(Voltage ~ date_time, data = data, type ="l",xlab = "datetime")

plot(Sub_metering_1 ~ date_time, data = data, col = "green",  ylab = "Energy sub metering", xlab = "", ylim = c(0,30)  );
lines(Sub_metering_2 ~ date_time, data = data, col = "red", xlab = "", ylim = c(0,30));
lines(Sub_metering_3 ~ date_time, data = data, col = "blue", xlab = "", ylim = c(0,30));
legend("topright", lty=c(1,1), col = c("green", "red", "blue"), legend = columnNames[7:9])



plot(Global_reactive_power ~ date_time, data = data, type ="l",xlab = "datetime")

dev.off();
