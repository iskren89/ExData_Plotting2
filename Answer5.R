library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC.motor <- grepl("Mobile - On-Road", SCC$EI.Sector)
SCC.subset2 <- SCC[SCC.motor,]
NEI.subset2 <- NEI[NEI$SCC %in% SCC.subset2$SCC,]
baltimore_motor<-filter(NEI.subset2,fips == "24510")
baltimore_motor_year<-group_by(baltimore_motor,year)
baltimore_motor_total<-summarise(baltimore_motor_year,Emissions=sum(Emissions))
png(file="Answer5.png", width=480, height=480)
par(cex.axis=0.7)
with(baltimore_motor_total, plot(year,Emissions, main="Baltimore Motor Vehicle Emissions 1999-2008"))
with(baltimore_motor_total, lines(year,Emissions))
dev.off()