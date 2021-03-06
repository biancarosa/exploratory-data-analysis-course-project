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


emissions_baltimore <- aggregate(Emissions ~ year, subset(sdata, fips == "24510" & type=="ON-ROAD"), sum)

library(ggplot2)
png("plot5.png")
plot <- ggplot(emissions_baltimore, aes(factor(year), Emissions))
plot <- plot + geom_bar(stat="identity")
plot <- plot + xlab("Year")
plot <- plot + ylab("Total Emissions from PM2.5")
plot <- plot + ggtitle("Emissions from motor vehicle sources in Baltimore City")
print(plot)
dev.off()