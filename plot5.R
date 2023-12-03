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

# Plot5: How have emissions from motor vehicle 
# sources changed from 1999–2008 in Baltimore City?

# Subset of data for Baltimore City, Maryland motor vehicle sources
bmmv <- subset(NEI, fips == "24510" & type =="ON-ROAD")

#bmmvyear <- with(bmmv, tapply(Emissions, year, sum))
#bmmvyear
#      1999      2002      2005      2008 
# 346.82000 134.30882 130.43038  88.27546

# Activate png device of specified width 600 pixels and height 480 pixels
png("plot5.png", width=600, height=480)

# Plot total (sum) PM2.5 by year
ggplot(data = bmmv, aes(factor(year), Emissions)) + 
  geom_col(width = .4, colour = "green3") +
  labs(x = "Year", 
       y = "Amount of PM 2.5 Emitted (tons)", 
       title = "Total Emissions by Year from Motor Vehicle Sources", 
       subtitle = "Baltimore City, Maryland")

# Close png device and save plot5.png file in working directory
dev.off() # plot5.png created and available for viewing