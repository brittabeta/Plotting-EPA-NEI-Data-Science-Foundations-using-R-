# Download data and unzip
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataEPA.zip"))
unzip(zipfile = "dataEPA.zip")

# Read data and source code information
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot1: Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the total 
# PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Find sum of emissions by year
pmyear <- with(NEI, tapply(Emissions, year, sum))

#pmyear
#1999    2002    2005    2008 
#7332967 5635780 5454703 3464206 

# Create x values
year <- unique(NEI$year)

# Activate png device of specified width 480 pixels and height 480 pixels
png("plot1.png", width=480, height=480)

# Plot total (sum) PM2.5 by year
plot(year, pmyear, pch = 19, type = "b", col = "red", xlab = "Year", ylab = "Amount of PM 2.5 Emitted (tons)", main = "Total Emissions by Year (From all Sources)")

# Close png device and save plot1.png file in working directory
dev.off() # plot1.png created and available for viewing