# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

#NEI
#SCC
source("loadData.R")

# Baltimore City only
Baltimore = NEI[NEI$fip=="24510",]
years = c(1999,2002,2005,2008)
total_emissions = sapply(years,function(year) sum(Baltimore$Emissions[Baltimore$year==year],rm.na=TRUE)/1e3)

# Calculate drop in emissions
total_emissions_drop = round(total_emissions[2:4] - total_emissions[1:3],digits = 2) 

# Calaculate average
y = (total_emissions[2:4] + total_emissions[1:3])/2
x = (years[2:4] + years[1:3])/2

# Open PNG device
png(filename="plot2.png")

# Draw plot
plot(years, total_emissions, ylim=c(0,4), yaxs="i", main="Total Annual PM2.5 emissions (Baltimore City, Maryland)", xlab="Year",ylab="Total Emissions (1,000 tons)") 
# Draw Lines
lines(years, total_emissions) 
# Add annotation for emission drop across years
text(x, y, labels=total_emissions_drop,pos=3,offset=1)

# Write to PNG
dev.off()