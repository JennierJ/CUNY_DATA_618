# Data 618 Week 1 Assignment_Jenny

#Load packages
install.packages("feasts")
install.packages("tsibble")
install.packages("lubridate")
install.packages("TSstudio")
install.packages("anytime")

# Load libraries
library(feasts)
library(tsibble)
library(lubridate)
library(TSstudio)
library(anytime)

# Load Data
data1 <- read.csv("https://raw.githubusercontent.com/JennierJ/CUNY_DATA_618/main/FEDFUNDS.csv", header = TRUE)
head(data1)
dim(data1)
data1$Month_Yr <- format(as.Date(data1$DATE), "%Y-%m")
data1 <- data1[, c(2,3)]
View(data1)
summary(data1)


data2 <- read.csv("https://raw.githubusercontent.com/JennierJ/CUNY_DATA_618/main/united-states-gdp-growth-rate.csv", header = TRUE)
head(data2)
summary(data2)
data2$newdate <- anydate(data2$date)
data2$Month_Yr <- format(as.Date(data2$newdate), "%Y-%m")
data2 <- data2[, c(2,5)]
View(data2)
#format(anydate(data2$date), "%y-%m-%d")
#class(data2$date)
#data2 <- as.numeric(as.character(data2$date))
#data2$date
#format(as.Date(data2$date), "%y-%m-%d")
#is.Date(data2$date)
#as.Date(data2$date)
#data2$newdate <- strptime(as.character(data2$date), "%m/%d/%y")
#data2$Month_Yr <- format(as.Date(data2$newdate), "%Y-%m")

data <- merge(data1, data2, by.x = "Month_Yr")
head(data)
dim(data)
View(data)


# ts function
data_ts <- ts(data = data[, c("FEDFUNDS", "GDP.Growth....")],
              start = c(1961, 12),
              end = c(2021, 12),
           frequency = 1)

ts_info(data_ts)
ts_plot(data_ts,
        title = "U.S. GDP Growth Rate vs. Federal Funds Effective Rate",
        Ytitle = "%",
        Xtitle = "Year")


#plot(data$Month_Yr,                              # Draw first time series
#     data$FEDFUNDS,
#     type = "l",
#     col = 2,
#     ylim = c(- 15, 40),
#     xlab = "Time",
#     ylab = "Rate")
#lines(data$Month_Yr,                             # Draw second time series
#      data$GDP.Growth....,
#      type = "l",
#      col = 3)
#legend("topright",                           # Add legend to plot
#       c("ts1", "ts2"),
#       lty = 1,
#       col = 2:4)


