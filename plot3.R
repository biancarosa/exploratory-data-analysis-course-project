# Setup variables. Change the working dir to match your user if you need to run the script.
setwd("/home/bianca/R/exploratory-data-analysis/project/data")
destfile <- "exdata_data_NEI_data.zip"

# Downloading required files if they do not exist
if (!file.exists(destfile)){
  print("Downloading file")
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(fileURL, destfile, method="curl")
}  
print("Unzipping file")
unzip(destfile)

cdata <- readRDS("Source_Classification_Code.rds")
sdata  <- readRDS("summarySCC_PM25.rds")

emissions_baltimore <- aggregate(Emissions ~ year + type, subset(sdata, fips == "24510"), sum)

library(ggplot2)
png("plot3.png")
plot <- ggplot(emissions_baltimore, aes(year, Emissions, color = type))
plot <- plot + geom_line()
plot <- plot + xlab("Year")
plot <- plot + ylab("Emissions from PM2.5")
plot <- plot + ggtitle("Total emissions from PM2.5 in Baltimore City, by type of poluttant sources")
plot <- plot +guides(fill=guide_legend(title="Type of pollutant source"))
print(plot)
dev.off()