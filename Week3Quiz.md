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


