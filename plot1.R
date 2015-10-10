
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis")

if (exists("powerData") == FALSE){
  powerData = read.table(unz("exdata-data-household_power_consumption.zip", "household_power_consumption.txt"), 
                    header=T, sep=";", stringsAsFactors = FALSE);
  powerData = subset(powerData, Date == "1/2/2007" | Date == "2/2/2007");
  powerData[, c(3:9)] <- sapply(powerData[, c(3:9)], as.numeric);
}

################

png("plot1.png", width = 480, height = 480)
hist(x = powerData$Global_active_power, col = "red",  xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

dev.off()
