# Download data and unzip
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataEPA.zip"))
unzip(zipfile = "dataEPA.zip")

# Read data and source code information
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot2: Have total emissions from PM2.5 decreased in Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system 
# to make a plot answering this question.

# Subset of data for Baltimore City, Maryland
bm <- subset(NEI, fips == "24510")

# Find sum of emissions by year
pmyearbm <- with(bm, tapply(Emissions, year, sum))

#pmyearbm
#1999     2002     2005     2008 
#3274.180 2453.916 3091.354 1862.282 

# Create x values
year <- unique(bm$year)

# Activate png device of specified width 480 pixels and height 480 pixels
png("plot2.png", width=480, height=480)

# Plot total (sum) PM2.5 by year
plot(year, pmyearbm, pch = 19, type = "b", col = "green", xlab = "Year", ylab = "Amount of PM 2.5 Emitted (tons)", main = "Total Emissions by Year (From all Sources)", sub = "Baltimore City, Maryland")

# Close png device and save plot1.png file in working directory
dev.off() # plot2.png created and available for viewing