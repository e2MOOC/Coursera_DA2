NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

SCClevels = sort(unique(SCC$SCC))
#NEI$fips = factor(NEI$fips)
NEI$SCC = factor(NEI$SCC,levels=SCClevels)
NEI$Pollutant = factor(NEI$Pollutant)
NEI$type = factor(NEI$type)

SCC$SCC = factor(SCC$SCC,levels=SCClevels)
