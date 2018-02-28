# Week 3 Quiz

Coursera's Data Specialization // Getting and Cleaning Data // Week 3 Quiz

## Question 1

The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

[2006 Housing Data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv)

and load the data into R. The code book, describing the variable names is here:

[Codebook](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf)

Create a logical vector that identifies the households on greater than 10 acres who sold 
more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. 
Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE.

which(agricultureLogical)

What are the first 3 values that result?

```r
# download data

housingUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"

download.file(housingUrl, destfile = "housing.csv")

dateDownloaded <- date()

housingData <- read.table("housing.csv", sep = ",", header = TRUE)

library(dplyr)

housingData_df <- tbl_df(housingData)

which(housingData_df$ACR == "3" & housingData_df$AGS == "6") # returns row values
```

## Question 2

Using the jpeg package read in the following picture of your instructor into R

[Image](https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg)

Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

### Prerequisites

You will need to install `install.packages()` and load `library()` jpeg package.

```r
jpegUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"

download.file(jpegUrl, destfile = "jeff.jpg", mode = "wb") # need additional mode argument to download jpeg

library(jpeg) # don't forget to install if necessary!

jeff <- readJPEG("jeff.jpg", native = TRUE) # creates object 'jeff' of class nativeRaster

quantile(jeff, probs = c(.3, .8)) # returns answer
```

## Question 3

Question 3
Load the Gross Domestic Product data for the 190 ranked countries in this data set:

[GDP Data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv)

Load the educational data from this data set:

[Educational Data](https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv)

Match the data based on the country shortcode. How many of the IDs match? 
Sort the data frame in descending order by GDP rank (so United States is last). 
What is the 13th country in the resulting data frame?

Original data sources:

http://data.worldbank.org/data-catalog/GDP-ranking-table

http://data.worldbank.org/data-catalog/ed-stats

```r
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
```

## Question 4

What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?

```r
#read as data frame tbl

mergedData <- tbl_df(mergedData)

# Filtering only 1st Group High Income OECD

high_inc_OECD <- filter(mergedData, Income.Group == "High income: OECD")

mean(high_inc_OECD$V2) #mean rank

# Filtering only 2nd High income: nonOECD

high_inc_nonOECD <- filter(mergedData, Income.Group == "High income: nonOECD")

mean(high_inc_nonOECD$V2) #mean rank
```

## Question 5

Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
How many countries are Lower middle income but among the 38 nations with highest GDP?

### Prerequisites

You will need to install `install.packages()` and load `library()` Hmisc package.

```r
library(Hmisc)

mergedData$gdpQuant <- cut2(mergedData$V2, g=5) # create 'gdpQuant' variable quantiles using cut2()

# cross tabs option

xtabs(~ mergedData$gdpQuant + mergedData$Income.Group)

# table option (same as above, slightly different syntax)

table(mergedData$gdpQuant, mergedData$Income.Group) # table of GDP rank Quantile by Income Group

# lastly, a filter option, then counting the number of observations

gdp_top38_lomiGroup <- filter(mergedData, V2 <=38, Income.Group == "Lower middle income") #creates df object

nrow(gdp_top38_lomiGroup) # counts observations/rows

