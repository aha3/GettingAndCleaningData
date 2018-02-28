## Week 3 Quiz ##

# Question 1 ACS logical vector #

# download data

housingUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(housingUrl, destfile = "housing.csv")

dateDownloaded <- date()

housingData <- read.table("housing.csv", sep = ",", header = TRUE)

library(dplyr)

housingData_df <- tbl_df(housingData)

which(housingData_df$ACR == "3" & housingData_df$AGS == "6") # returns row values


# Question 2 jpeg package #

jpegUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(jpegUrl, destfile = "jeff.jpg", mode = "wb") # need additional mode argument to download jpeg

library(jpeg) # don't forget to install if necessary!

jeff <- readJPEG("jeff.jpg", native = TRUE) # creates object 'jeff' of class nativeRaster

quantile(jeff, probs = c(.3, .8)) # returns answer



# Question 3 GDP Country Data #

#download data

gdpData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"

edData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"

download.file(gdpData, destfile = "gdp.csv")

download.file(edData, destfile = "edData.csv")

# need to specify how many lines to skip and rows to read

gdpData <- read.csv("gdp.csv", header = FALSE, skip = 5, nrows = 190) 

# need to use read.delim beacause of quotes in file

edData <- read.delim("edData.csv", sep = ",", header = TRUE) 

# now time to merge -- argument 'all' remains default (FALSE) meaning only matching rows are returned

mergedData <- merge(gdpData, edData, by.x = "V1", by.y = "CountryCode", all = FALSE) # produces dimensions of 189 x 40

#find how many ids matched

matches <- sum(!is.na(unique(mergedData2$V1))) # selected variable is country code

print(matches)

#arrange data
library(dplyr)

arranged_data <- arrange(mergedData2, desc(V2)) #arranges by GDP rank

arranged_data[13, "Long.Name"] # pulls out 13th country


# Question 4 Average GDP by Income Group #
 
#read as data frame tbl

mergedData <- tbl_df(mergedData)

# Filtering only 1st Group High Income OECD

high_inc_OECD <- filter(mergedData, Income.Group == "High income: OECD")

mean(high_inc_OECD$V2) #mean rank

# Filtering only 2nd High income: nonOECD

high_inc_nonOECD <- filter(mergedData, Income.Group == "High income: nonOECD")

mean(high_inc_nonOECD$V2) #mean rank


# Question 5 GDP Quantile and Income Group #

#load Hmisc to use cut2() and create quantile groups

library(Hmisc)

mergedData$gdpQuant <- cut2(mergedData$V2, g=5) # create 'gdpQuant' variable quantiles using cut2()

# cross tabs option

xtabs(~ mergedData$gdpQuant + mergedData$Income.Group)

# table option (same as above, slightly different syntax)

table(mergedData$gdpQuant, mergedData$Income.Group) # table of GDP rank Quantile by Income Group

# lastly, a filter option, then counting the number of observations

gdp_top38_lomiGroup <- filter(mergedData, V2 <=38, Income.Group == "Lower middle income") #creates df object

nrow(gdp_top38_lomiGroup) # counts observations/rows

