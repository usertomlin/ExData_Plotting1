
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




