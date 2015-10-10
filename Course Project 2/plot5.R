
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis/CourseProject2");

if (exists("NEI") == FALSE || exists("SCC") == FALSE) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds");
}

emissions = data.frame(matrix(0, 1, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");

vehicleRelatedSCC = subset(SCC, grepl(pattern = "vehicle", x = Short.Name, ignore.case = TRUE))
vehicleRelatedSCC = vehicleRelatedSCC[, c("SCC", "Short.Name")]
vehicleRelatedNEI = merge(filter(NEI, fips == "24510"), vehicleRelatedSCC, by.x = "SCC", by.y = "SCC")

emissions = data.frame(matrix(0, 1, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");

for (i in 1:4){
  emissions[i] = sum(subset(vehicleRelatedNEI, year == 1996 + 3*i)$Emissions);
}


png("plot5.png", width = 600, height = 600)
bp = barplot(as.matrix(emissions), names = colnames(emissions), col = "cyan", 
             xlab = "Year", col.axis = "darkgreen",
             ylab = "Total Emissions (in tons)", ylim = c(0,max(emissions) * 1.3),
             cex.names=1.3, cex.axis = 1.3, cex.lab = 1.5, cex.main = 1.5, 
             main = "PM2.5 Emissions in Baltimore from motor vehicle sources" );
lines(bp, emissions[1,1:4], col = "darkgreen");
for (i in 1:4){
  text(-0.5+1.2*i, emissions[i]+5, format(emissions[i], digits = 5), col = "red")
}

dev.off()