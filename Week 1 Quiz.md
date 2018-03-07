# Week 1 Quiz from Coursera's Getting and Cleaning Data Module in the Data Science Specialization

## Question 1
The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

and load the data into R. The code book, describing the variable names is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf

How many properties are worth $1,000,000 or more?

```r
housingUrl <- https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv  	#first have to create object with Url

download.file(housingUrl, destfile = "housing.csv")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
Content type 'text/csv' length 4246554 bytes (4.0 MB)
downloaded 4.0 MB

library(dplyr)

#reading as table.df

housingData_df <- tbl_df(housingData)

head(housingData_df)

filter(housingData_df, ST == "16", VAL >= "24")
```

## Question 2

Use the data you loaded from Question 1. 
Consider the variable FES in the code book. 

Which of the "tidy data" principles does this variable violate?

```
Tidy data has one variable per column.
```

## Question 3

Download the Excel spreadsheet on Natural Gas Aquisition Program here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx

Read rows 18-23 and columns 7-15 into R and assign the result to a variable called:

`dat`

What is the value of:
`sum(dat$Zip*dat$Ext,na.rm=T)`

```r
gasData <- read.xlsx("NGAP.xlsx", sheetIndex = 1, header = TRUE)

sum(dat$Zip*dat$Ext,na.rm=T) # returns answer
```
> This question is particularly meaningless, as it’s asking you to add up the product of ZIP codes and some ‘Ext’ variable, 
which I can’t think of when one would need to do this, other than to test somebody’s ability to do it...

## Question 4

Read the XML data on Baltimore restaurants from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml

How many restaurants have zipcode 21231?

```r
colnames(zipcodedf)
> [1] "value"

library(dplyr)

filter(zipcodedf, value == "21231") # returns answer

## Question 5

The American Community Survey distributes downloadable data about United States communities. 
Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:

https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv

using the fread() command load the data into an R object

`Dt`

The following are ways to calculate the average value of the variable `pwgtp15` broken down by sex. 

Using the data.table package, which will deliver the fastest user time?

```r
## SOURCE CREDIT: https://github.com/zezutom/datasciencecoursera/tree/master/getcleandata/quiz1 ###

funs <- list(
  fun1 = function() { sapply(split(DT$pwgtp15,DT$SEX),mean) },
  fun2 = function() { tapply(DT$pwgtp15,DT$SEX,mean) },
  fun3 = function() { mean(DT$pwgtp15,by=DT$SEX) },
  fun4 = function() { DT[,mean(pwgtp15),by=SEX] },
  fun5 = function() { rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2] },
  fun6 = function() { mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15) }
)

## set to FALSE if you want to remove verbose logs below
debug <- TRUE

fastest <- NULL
min <- .Machine$integer.max

lapply(funs, function(FUN) {
  if (debug) print(FUN)
  st <- system.time(x <- try(FUN(), silent = TRUE))
  if (inherits(x, "try-error")) {
    if(debug) print("run-time error, skipping..")  
  } else {
    et <- st[3]
    if (et < min) {
      min <<- et
      fastest <<- FUN
    }
    if (debug) {
      print(paste("elapsed time:", sprintf("%.10f", et)))
      print(x)      
    }
  }
})

## The function 'mean(DT$pwgtp15,by=DT$SEX)' should be the fastest one.
print("The fastest calculation is:")
print(fastest)
msg("with running time of", sprintf("%.10f", min), "seconds")
```







