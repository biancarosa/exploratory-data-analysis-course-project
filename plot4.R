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

coal <- cdata[grepl("coal", cdata$Short.Name, ignore.case=TRUE),]
merged <- merge(sdata, coal, by="SCC")
merged <- merged[,c("SCC", "Emissions", "Pollutant", "year", "type")]

emissions_by_year <- aggregate(Emissions ~ year, merged, sum)


library(ggplot2)
png("plot4.png")
plot <- ggplot(emissions_by_year, aes(factor(year), Emissions))
plot <- plot + geom_bar(stat="identity")
plot <- plot + xlab("Year")
plot <- plot + ylab("Total Emissions from PM2.5")
plot <- plot + ggtitle("Emissions from coal combustion-related sources across the USA")
print(plot)
dev.off()