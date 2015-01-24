# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

# Baltimore City only
Baltimore = NEI[NEI$fip=="24510",]

# regex to identify SCC related to motor vehicle
veh = grepl("Veh",SCC$Short.Name, ignore.case=TRUE)
vehSCC = SCC$SCC[veh]
# subset data frame to for motor vehicle emission
veh_emissions = subset(Baltimore, SCC %in% vehSCC, select = c(Emissions,year,SCC))


# get emission by SCC and year 
Baltimore_emissions = with(veh_emissions,by(Emissions,list(year,SCC),sum))
# get SCC
year = rownames(Baltimore_emissions)
# get year
veh = as.vector(sapply(colnames(Baltimore_emissions),function(x)rep(x,4)))
# get emission values
emissions = as.vector(Baltimore_emissions,mode='numeric')
# create data Frame to represent emission by type and year
data = data.frame(emissions,veh,year)
data = data[!is.na(data$emissions),]

# load ggplot
library(ggplot2) 
# ggplot
gplot = qplot(veh, emissions, data=data, facets=~year, geom="point", main="Annual Emissions by motor vehicle Sources (Baltimore City)", xlab="Emission Source (motor vehicle)", ylab="Annual Emissions by Source (ton)") 
# Open PNG device
png(filename="plot5.png")
# print ggplot to device
print(gplot)
# Write to PNG
dev.off()
