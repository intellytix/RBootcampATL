# Set and confirm the Working Directory
setwd("C:/Users/Admin/Documents/$R/DataPrep")
getwd()
#Create Data Directory if does not exists
if (!file.exists("data")) {dir.create("data")}
#Download raw data to data folder
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile="./data/power.zip")
setwd("C:/Users/Admin/Documents/$R/Data")
unzip("./power.zip")
list.files(".")
setwd("C:/Users/Admin/Documents/$R/DataPrep")
labels <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1, quote = "")
data <- read.table("./data/household_power_consumption.txt", header = FALSE, sep = ";", skip= 68076, nrows = 2880, quote = "")
colNames <- colnames(labels)
colnames(data) = colNames

filexlsx <- "getdata_data_DATA.gov_NGAP.xlsx"
xlsxData <- read.xlsx(filexlsx, 1, header = TRUE,  startRow=17, endRow=23, colIndex=NULL,
                      as.data.frame=TRUE, header=TRUE, colClasses=NA)


getwd()
#Download Excell file to data folder
fileURLxls <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileURLxls, destfile="./data/cameras.xlsx", mode="wb")
downloaded <- date()
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex = 1, header = TRUE)
head(cameraData)
#subsetting in excel 
colIndex <- 2:3 #Sets the COlumns to ony 2 and 3
rowIndex <- 1:4 # Sets the rows to the first 4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex = 1, colIndex = colIndex, rowIndex = rowIndex)
# write.xlsx is same as read, h oever, saving data is best in DB or csv/txt
#read.xlsx2 is faster but unstable with subsetting 

# Important to notice the use of file in mySql, while we use the actual file name in read
mySql <- "SELECT * FROM file WHERE Date='1/2/2007' OR Date='2/2/2007'"
dfData <- read.csv2.sql(myfile, sql = mySql, header = TRUE, sep = ";", row.names = FALSE )


###########################mySQL###########################

GnomeUrl <- "http://genome.ucsc.edu/"
SqlGnomeUrl <- "http://genome.ucsc.edu/goldenPath/help/mysql.html"