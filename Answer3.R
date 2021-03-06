library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimore<-filter(NEI,fips == "24510")
baltimore2<-group_by(baltimore,year,type)
baltimore3<-summarise(baltimore2,Emissions=sum(Emissions))
png(file="Answer3.png", width=480, height=480)
ggplot(baltimore3, aes(factor(year),Emissions))+facet_grid(type~.,scale="free")+geom_bar(stat="identity")+
  labs(x="Year",title="Emissions in Baltimore by type 1999-2008")
dev.off()