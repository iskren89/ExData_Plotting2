library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
SCC.coal <- grepl("Coal", SCC$EI.Sector)
SCC.subset <- SCC[SCC.coal,]
NEI.subset <- NEI[NEI$SCC %in% SCC.subset$SCC,]
subset_by_year<-group_by(NEI.subset,year)
subset_total<-summarise(subset_by_year,Emissions=sum(Emissions))
png(file="Answer4.png", width=480, height=480)
with(subset_total, plot(year,Emissions,main="Coal-Related Emissions 1999-2008"))
with(subset_total, lines(year,Emissions))
dev.off()