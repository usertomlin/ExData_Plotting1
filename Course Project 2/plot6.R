
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis/CourseProject2");

if (exists("NEI") == FALSE || exists("SCC") == FALSE) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds");
}

emissions = data.frame(matrix(0, 1, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");

vehicleRelatedSCC = subset(SCC, grepl(pattern = "vehicle", x = Short.Name, ignore.case = TRUE))
vehicleRelatedSCC = vehicleRelatedSCC[, c("SCC", "Short.Name")]
vehicleNEI_bal = merge(subset(NEI, fips == "24510"), vehicleRelatedSCC, by.x = "SCC", by.y = "SCC")
vehicleNEI_lac = merge(subset(NEI, fips == "06037"), vehicleRelatedSCC, by.x = "SCC", by.y = "SCC")

emissions = data.frame(matrix(0, 2, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");

for (i in 1:4){
  emissions[1,i] = sum(subset(vehicleNEI_bal, (year == 1996 + 3*i))$Emissions);
  emissions[2,i] = sum(subset(vehicleNEI_lac, (year == 1996 + 3*i))$Emissions);
}

emissions[1, ] = emissions[1, ] / emissions[1, 1];
emissions[2, ] = emissions[2, ] / emissions[2, 1];

png("plot6.png", width = 900, height = 600)


bp = barplot(as.matrix(emissions), beside = TRUE, names = colnames(emissions),  
             xlab = "Year", col.axis = "darkgreen",
             ylab = "Total Emissions (relative to 1999)", ylim = c(0,max(emissions) * 1.3),
             cex.names=1.3, cex.axis = 1.3, cex.lab = 1.5, cex.main = 1.5, 
             col=c("darkblue","red"),
             main = "PM2.5 Emissions (relative to 1999) in Baltimore and Los Angels from motor vehicle sources" );

for (i in 1:4){
  text(-1.5+3*i, emissions[1, i]+.06, format(emissions[1, i], digits = 4), col = "darkblue")
  text(-0.5+3*i, emissions[2, i]+.06, format(emissions[2, i], digits = 4), col = "red")
}
legend("topright", legend = c("Baltimore", "Los Angels"), fill = c("darkblue", "red"))

dev.off()

