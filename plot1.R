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

png('plot1.png')
emissions_by_year <- aggregate(Emissions ~ year, sdata, sum)
options(scipen=10)
barplot(emissions_by_year$Emissions, names.arg=emissions_by_year$year, xlab="Year", main="Total of pollutant emissions by year")
dev.off()