# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

#NEI
#SCC
source("loadData.R")

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
Baltimore_data = data.frame(emissions,veh,year,county="Baltimore")
Baltimore_data = Baltimore_data[!is.na(Baltimore_data$emissions),]



# California City only
California = NEI[NEI$fip=="06037",]

# regex to identify SCC related to motor vehicle
veh = grepl("Veh",SCC$Short.Name, ignore.case=TRUE)
vehSCC = SCC$SCC[veh]
# subset data frame to for motor vehicle emission
veh_emissions = subset(California, SCC %in% vehSCC, select = c(Emissions,year,SCC))


# get emission by SCC and year 
California_emissions = with(veh_emissions,by(Emissions,list(year,SCC),sum))
# get SCC
year = rownames(California_emissions)
# get year
veh = as.vector(sapply(colnames(California_emissions),function(x)rep(x,4)))
# get emission values
emissions = as.vector(California_emissions,mode='numeric')
# create data Frame to represent emission by type and year
California_data = data.frame(emissions,veh,year,county="California")
California_data = California_data[!is.na(California_data$emissions),]

# merge data frame
data = rbind(Baltimore_data,California_data)


# load ggplot
library(ggplot2) 
# ggplot
gplot = qplot( veh, emissions, data=data, facets=year~county, main="Annual Emissions by motor vehicle Sources\n(Baltimore vs. California)", xlab="Vehicle Emission Sources", ylab="Annual Emissions (ton)") 
gplot = gplot + geom_point(aes(size = emissions))  + theme(panel.grid.major.x = element_blank(), panel.grid.minor.x = element_blank())


# Open PNG device
png(filename="plot6.png", width=2000, height=1200)
# print ggplot to device
print(gplot)
# Write to PNG
dev.off()
