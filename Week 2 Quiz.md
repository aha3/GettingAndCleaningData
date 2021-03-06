# Week 3 Quiz

Coursera's Data Specialization // Getting and Cleaning Data // Week 2 Quiz

## Question 1

Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?
This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

```r
2013-11-07T13:25:07Z
```

The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL.
Download the American Community Survey data and load it into an R object called `acs`

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

```r
#install sqldf package

install.packages("sqldf")

#load package

library(sqldf)

#download data

acsUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(acsUrl, destfile = "acs.csv")

#read csv data into data frame

acs <- read.csv("acs.csv") #large data set (dimensions of 14931 x 239)
sqldf("select pwgtp1 from acs where AGEP < 50") 

# this selects variables ‘pwgtp1’ from data set ‘acs’ where variable AGEP < 50
```

## Question 3

Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

```r
sqldf("select distinct AGEP from acs")

# 'distinct’ is analogous to ‘unique’, so it must be included in call, and it specifies what (AGEP) from where (acs)
```

## Question 4

How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
http://biostat.jhsph.edu/~jleek/contact.html
(Hint: the nchar() function in R may be helpful)

```r
con = url("http://biostat.jhsph.edu/~jleek/contact.html") 

htmlCode = readLines(con)                    

close(con)

nchar(htmlCode[c(10, 20, 30, 100)])
```

## Question 5

Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
(Hint this is a fixed width file format)

```r
testData <- read.fwf("sstData.for", widths = c(9,5,4,5,4,5,4,5,4,5,4,5,4,5,4,5,4), skip = 4)

print(sum(testData$V6))
```


