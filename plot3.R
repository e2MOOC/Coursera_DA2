# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

#NEI
#SCC
source("loadData.R")

# Baltimore City only
Baltimore = NEI[NEI$fip=="24510",]

# get emission by type and year 
Baltimore_emissions = with(Baltimore,by(Emissions,list(type,year),sum))
# get type
type = rownames(Baltimore_emissions)
# get year
years = as.vector(sapply(colnames(Baltimore_emissions),function(x)rep(x,4)),mode='numeric')
# get emission values
emissions = as.vector(Baltimore_emissions,mode='numeric')
# create data Frame to represent emission by type and year
data = data.frame(emissions,type,years)

# load ggplot
library(ggplot2) 
# ggplot
gplot = qplot(years, emissions, data=data, facets=~type, geom=c("point", "line"), main="Annual Emissions by Type (Baltimore City)", xlab="Year", ylab="Emissions (ton)") 

# Open PNG device
png(filename="plot3.png")
# print ggplot to device
print(gplot)
# Write to PNG
dev.off()
