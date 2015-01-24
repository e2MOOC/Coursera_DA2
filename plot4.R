# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

#NEI
#SCC
source("loadData.R")

# regex to identify SCC related to coal and combustion
coal = grepl("Coal",SCC$Short.Name, ignore.case=TRUE)
comb = grepl("Comb",SCC$Short.Name, ignore.case=TRUE)
# get the list of SCC for coal and combustion source
coalCombSCC = SCC$SCC[coal&comb]
# subset data frame to for coalcomb emission
coal_emissions = subset(NEI, SCC %in% coalCombSCC, select = c(Emissions,year,fips))


# get emission by fips and year 
tmp = with(coal_emissions,by(Emissions,list(year,fips),sum))
# get type
year = rownames(tmp)
# get year
fips = as.vector(sapply(colnames(tmp),function(x)rep(x,4)))
# get emission values
emissions = as.vector(tmp,mode='numeric')
# create data Frame to represent emission by type and year
data = data.frame(emissions,fips,year)


years = c(1999,2002,2005,2008)

# Open PNG device
png(filename="plot4.png")

# Draw plot
boxplot(emissions~year,data=data, outline = FALSE, main="PM2.5 emissions \nfrom coal combustion-related sources",  xlab="Year", ylab="PM2.5 emissions by County (ton)")

# Write to PNG
dev.off()
