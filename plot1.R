# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

#NEI
#SCC
source("loadData.R")

years = c(1999,2002,2005,2008)
total_emissions = sapply(years,function(year) sum(NEI$Emissions[NEI$year==year],rm.na=TRUE)/1e6)

# Calculate drop in emissions
total_emissions_drop = round(total_emissions[2:4] - total_emissions[1:3],digits = 2) 

# Calaculate average
y = (total_emissions[2:4] + total_emissions[1:3])/2
x = (years[2:4] + years[1:3])/2

# Open PNG device
png(filename="plot1.png")

# Draw plot
plot(years, total_emissions, ylim=c(0,8), yaxs="i", main="Total Annual PM2.5 emissions from all sources", xlab="Year",ylab="Total Emissions (1,000,000 tons)") 
# Draw Lines
lines(years, total_emissions) 
# Add annotation for emission drop across years
text(x, y, labels=total_emissions_drop,pos=3,offset=1)

# Write to PNG
dev.off()
