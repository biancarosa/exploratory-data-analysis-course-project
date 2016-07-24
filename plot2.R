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

emissions_baltimore <- aggregate(Emissions ~ year, subset(sdata, fips == "24510"), sum)


png('plot2.png')
plot(emissions_baltimore$year, emissions_baltimore$Emissions, xlab="Year", ylab= "Total emissions from PM2.5", type="n", main="Emissions from PM2.5 through the years")
lines(emissions_baltimore$year, emissions_baltimore$Emissions)
dev.off()