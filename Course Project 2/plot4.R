
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis/CourseProject2");

if (exists("NEI") == FALSE || exists("SCC") == FALSE) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds");
}

coalRelatedSCC = subset(SCC, grepl(pattern = "coal", x = Short.Name, ignore.case = TRUE))
coalRelatedSCC = coalRelatedSCC[, c("SCC", "Short.Name")]
coalRelatedNEI = merge(NEI, coalRelatedSCC, by.x = "SCC", by.y = "SCC")

emissions = data.frame(matrix(0, 1, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");
for (i in 1:4){
  emissions[i] = sum(subset(coalRelatedNEI, year == 1996 + 3*i)$Emissions);
}

png("plot4.png", width = 600, height = 600)
options("scipen"=6)
bp = barplot(as.matrix(emissions), names = colnames(emissions), col = "cyan", 
             xlab = "Year", col.axis = "darkgreen", 
             ylab = "Total Emissions (in tons)", ylim = c(0,max(emissions) * 1.2), 
             cex.names=1.3, cex.axis = 1.3, cex.lab = 1.5, cex.main = 1.3, 
             main = "PM2.5 Emissions from coal combustion-related sources in the U.S.");
lines(bp, emissions[1,1:4], col = "darkgreen");
for (i in 1:4){
  text(-0.5+1.2*i, emissions[i]+30000, format(emissions[i], digits = 6), col = "red")
}

dev.off()
