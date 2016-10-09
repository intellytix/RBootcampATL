#Download raw data to data folder
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./power.zip")

unzip("./power.zip")
list.files(".")
# setwd("C:/Users/Admin/Documents/$R/DataPrep")
labels <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1, quote = "")
mydata <- read.table("./household_power_consumption.txt", header = FALSE, sep = ";", skip= 68076, nrows = 2880, quote = "")
colNames <- colnames(labels)
colnames(mydata) = colNames