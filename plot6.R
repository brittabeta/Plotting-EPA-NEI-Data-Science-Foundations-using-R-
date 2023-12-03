# Load ggplot
library(ggplot2)
library(dplyr)

# Download data and unzip
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataEPA.zip"))
unzip(zipfile = "dataEPA.zip")

# Read data and source code information
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot6: Compare emissions from motor vehicle sources in Baltimore City 
# with emissions from motor vehicle sources in Los Angeles County, California 
# (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# Subset of data for Baltimore City, Maryland and Los Angeles County, 
# California and motor vehicle sources
bcmv <- subset(NEI, (fips == "24510" | fips == "06037") & type =="ON-ROAD")

# Some cleaning
bcmv$location <- recode(bcmv$fips, "24510" = "MA", "06037" = "CA")

#bcmvyear <- with(bcmv, tapply(Emissions, year, sum))
#bcmvyear
#1999     2002     2005     2008 
#4277.940 4408.019 4731.845 4189.596

# Activate png device of specified width 600 pixels and height 480 pixels
png("plot6.png", width=600, height=480)

# Plot total (sum) PM2.5 by year
ggplot(data = bcmv, aes(factor(year), Emissions, color = location)) + 
  geom_col(width = .4) +
  facet_grid(.~location) +
  labs(x = "Year", 
       y = "Amount of PM 2.5 Emitted (tons)", 
       title = "Total Emissions by Year from Motor Vehicle Sources", 
       subtitle = "Baltimore City, Maryland & Los Angeles County, California")

# Close png device and save plot6.png file in working directory
dev.off() # plot6.png created and available for viewing