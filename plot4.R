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

# Plot4: Across the United States, how have 
# emissions from coal combustion-related sources 
# changed from 1999–2008?

# subset of SCC codes: coal combustion-related
comb <- c("Fuel Comb - Electric Generation - Coal", 
            "Fuel Comb - Industrial Boilers, ICEs - Coal",
            "Fuel Comb - Comm/Institutional - Coal")
coal <- subset(SCC, EI.Sector %in% comb)
coalscc <- coal$SCC

# Subset of data for SCC codes related to combustion of coal
coalpm <- subset(NEI, SCC %in% coalscc)

# Find sum of emissions by year
coalyear <- with(coalpm, tapply(Emissions, year, sum))

# Create x values
year <- unique(coalpm$year)

# Activate png device of specified width 600 pixels and height 480 pixels
png("plot4.png", width=600, height=480)

# Plot total (sum) PM2.5 by year
ggplot(data = coalpm, aes(factor(year), Emissions)) + 
  geom_col(width = .4, col = "steelblue") +
  labs(x = "Year", 
       y = "Amount of PM 2.5 Emitted (tons)", 
       title = "Total Emissions by Year", 
       subtitle = "Coal Combustion Related Sources")

# Close png device and save plot3.png file in working directory
dev.off() # plot4.png created and available for viewing