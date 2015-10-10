
setwd("D:/Online Courses/Data Science/Exploratory Data Analysis/CourseProject2");

if (exists("NEI") == FALSE || exists("SCC") == FALSE) {
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds");
}

library("ggplot2");

emissions = data.frame(matrix(0, 1, 4));
colnames(emissions) = c("1999", "2002", "2005", "2008");
balNEI = subset(NEI, fips == "24510");
balEmissions = balNEI[, c("year", "type", "Emissions")];

types = unique(balEmissions$type);
years = unique(balEmissions$year);

balEmissions = balEmissions[1:(length(types) * length(years)), ];

r = 0;
for (t in types){
  typeData = subset(balNEI, type == t);
  for (y in years){  
    r = r + 1;
    typeYearData = subset(typeData, year == y);
    balEmissions[r, ] = c(y, t, sum(typeYearData$Emissions));
  }
}

balEmissions$Emissions = round(as.numeric(balEmissions$Emissions), 2)
balEmissions$year = as.factor(balEmissions$year);
balEmissions$type = as.factor(balEmissions$type);

png("plot3.png", width = 800, height = 600)

ggplot(data = balEmissions, aes(type, Emissions, fill=year)) + 
  geom_bar(stat="identity", position="dodge") + 
  theme(axis.text=element_text(size=14), axis.title=element_text(size=18,face="bold"),
        legend.text = element_text(colour="brown", size=10, face="bold") );
  
dev.off()

