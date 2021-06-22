############################################################################################################
#
# Author: Devin Teran
# Date: 2021-06-06
# Homework Problems Week 1
#
############################################################################################################

#Libraries
library(ggplot2)
library(fpp)
library(ggfortify)
############################################################################################################
#Exercise 2.1
############################################################################################################
#Use the help function to explore what the series gold, woolyrnq and gas represent.

#The series gold represents daily gold prices in US dollars from January 1, 1985 to March 31,1989.
help(gold)
#The series woolyrnq represents quarterly wool yarn production in Australia in tonnes from March 1965 to September 1994.
help(woolyrnq)
#The series gas represents monthly gas production in Australia from 1956 to 1995.
help(gas)

#Use autoplot() to plot each of these in separate plots.
#Autopilot gold
autoplot(gold) +
  ggtitle("Gold Prices in US Dollars") +
  xlab("Day") +
  ylab("US Dollars")

#Autopilot woolyrnq
autoplot(woolyrnq) +
  ggtitle("Quarterly Wool Yarn Production in Australia") +
  xlab("Year") +
  ylab("Tonnes of Yarn")

#Autopilot gas
autoplot(gas) +
  ggtitle("Gas Production in Australia") +
  xlab("Year") +
  ylab("Gas Production")

#What is the frequency of each series? Hint: apply the frequency() function.
#The frequency of the gold series is 1 which means daily frequency.
frequency(gold)

#The frequency of the woolyrnq series is 4 which means quarterly frequency.
frequency(woolyrnq)

#The frequency of the gas series is 12 which means mnonthly frequency.
frequency(gas)

#Use which.max() to spot the outlier in the gold series. Which observation was it?
#The 770th observation is the outlier in the gold series with a value of 593.7.
which.max(gold)

############################################################################################################
#Exercise 2.3
############################################################################################################
#Download some monthly Australian retail data from the book website. 
#These represent retail sales in various categories for different Australian states, 
#and are stored in a MS-Excel file.

#You can read the data into R with the following script:
library(xlsx)
retaildata <- readxl::read_excel("retail.xlsx", skip=1)
head(retaildata)
#The second argument (skip=1) is required because the Excel sheet has two header rows.

#Select one of the time series as follows (but replace the column name with your own chosen column):
myts <- ts(retaildata[,"A3349335T"],frequency=12, start=c(1982,4))

#Explore your chosen retail time series using the following functions:
  
#  autoplot()
autoplot(myts) +
  ggtitle("AutoPlot: A3349335T Retail Sales") +
  xlab("Year")

#  ggseasonplot()
ggseasonplot(myts, col=rainbow(12), year.labels=TRUE) +
  ylab("Sales") +
  ggtitle("Seasonal Plot: A3349335T Retail Sales")

#  ggsubseriesplot()
ggsubseriesplot(myts) +
  ylab("Sales") +
  ggtitle("Seasonal Subseries Plot: A3349335T Retail Sales")

#  gglagplot()
gglagplot(myts)

#  ggAcf()
ggAcf(myts)

#Can you spot any seasonality, cyclicity and trend? What do you learn about the series?
#There is definite seasonality.  Sales increase at the end of December signficantly.
#There is also an increasing trend.

############################################################################################################
#Exercise 6.2
############################################################################################################
# The plastics data set consists of the monthly sales (in thousands) of product A for a plastics manufacturer for five years.
# 
# Plot the time series of sales of product A. Can you identify seasonal fluctuations and/or a trend-cycle?

autoplot(plastics) +
  ggtitle("Monthly Sales (in thousands for product A") +
  xlab("Year")

#Seasonal: there are definite season trends with spikes in sales in the summer months and lows being in February.
ggseasonplot(plastics, col=rainbow(12), year.labels=TRUE) +
  ylab("Sales") +
  ggtitle("Seasonal Plot: Plastic Sales")

ggsubseriesplot(plastics, col=rainbow(12), year.labels=TRUE) +
  ylab("Sales") +
  ggtitle("Seasonal Plot: Plastic Sales")

#   Use a classical multiplicative decomposition to calculate the trend-cycle and seasonal indices.
plastics %>% decompose(type="multiplicative") %>% autoplot() 
  
# Do the results support the graphical interpretation from part a?
# There are clear seasonal and increasing trend which support the previous graphical interpretation.

#Compute and plot the seasonally adjusted data.
library(seasonal)
plastics %>% seas(x11="") -> fit

autoplot(plastics, series="Data") + +
  autolayer(seasadj(adj_seasonal_plastics), series="Seasonally Adjusted") +
  scale_colour_manual(values=c("gray","blue"),
                      breaks=c("Data","Seasonally Adjusted"))
# Change one observation to be an outlier (e.g., add 500 to one observation), and recompute the seasonally adjusted data. 
#What is the effect of the outlier?


#   Does it make any difference if the outlier is near the end rather than in the middle of the time series?