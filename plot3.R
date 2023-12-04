# Load ggplot
library(ggplot2)

# Download data and unzip
path <- getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, file.path(path, "dataEPA.zip"))
unzip(zipfile = "dataEPA.zip")

# Read data and source code information
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot3: Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen decreases 
# in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
# emissions from 1999–2008? Use the ggplot2 plotting system to make a plot to 
# answer this question..

# Subset of data for Baltimore City, Maryland
bm <- subset(NEI, fips == "24510")

# Find sum of emissions by year
pmyearbm <- with(bm, tapply(Emissions, year, sum))

# Create x values
year <- unique(bm$year)

# Activate png device of specified width 600 pixels and height 480 pixels
png("plot3.png", width=600, height=480)

# Plot total (sum) PM2.5 by year
ggplot(data = bm, aes(factor(year), Emissions, color = type)) + 
  geom_col() + 
  facet_grid(.~type) +  
  labs(x = "Year", 
       y = "Amount of PM 2.5 Emitted (tons)", 
       title = "Total Emissions by Year and Source", 
       subtitle = "Baltimore City, Maryland")

# Close png device and save plot3.png file in working directory
dev.off() # plot3.png created and available for viewing