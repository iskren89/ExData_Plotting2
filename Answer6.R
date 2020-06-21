library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC.motor <- grepl("Mobile - On-Road", SCC$EI.Sector)
SCC.subset2 <- SCC[SCC.motor,]
NEI.subset2 <- NEI[NEI$SCC %in% SCC.subset2$SCC,]
baltimore_motor<-filter(NEI.subset2,fips == "24510")
la_motor<-filter(NEI.subset2,fips == "06037")
cities_motor<-rbind(baltimore_motor,la_motor)
cities_by_year<-group_by(cities_motor,year,fips)
cities_total<-summarise(cities_by_year,Emissions=sum(Emissions))
cities_names <- c('06037'="LA", '24510'="Baltimore")
png(file="Answer6.png", width=480, height=480)
ggplot(cities_total, aes(factor(year),Emissions))+
  facet_grid(fips~.,scale="free",labeller = as_labeller(cities_names))+
  geom_bar(stat="identity")+labs(x="Year",title="Vehicle Emissions in Baltimore&LA 1999-2008")
dev.off()

