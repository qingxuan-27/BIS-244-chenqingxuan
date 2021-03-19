#Midterm by Qingxuan

#Clear the Working Directory and Console
rm(list=ls(all=TRUE))
cat("\014")

#Use Package readr
library(tidyverse)

#Lock the Working Directory
Temp <- getwd()

#Read the AAPL.csv as a data frame
RESULTS <- read_csv("AAPL.csv")
View(RESULTS)

RESULTS$Difference <- 0
RESULTS$UpDown <- NA
View(RESULTS)

n_RESULTS <- length(RESULTS$Date)
n_RESULTS

temp = c()
temp = 0
View(temp)
for(v in 2:n_RESULTS){
  temp[v] <- RESULTS$`Adj Close`[v]-RESULTS$`Adj Close`[v-1]
}
RESULTS$Difference <- temp
View(RESULTS)

for(v in 1:n_RESULTS){
  if(RESULTS$Difference[v]>0){
    RESULTS$UpDown[v] <- "Up"
  }
  else if(RESULTS$Difference[v] < 0){
    RESULTS$UpDown[v] <- "Down"
  }
}

View(RESULTS)

# Make a plot
p <- ggplot(data=RESULTS, aes(x=Date, y=Difference, color = UpDown))
p + geom_point(aes(color = UpDown)) +
  labs (x = "03/19/2020 through 03/18/2021", y = "Change in Adjusted Closing Price",
        title = "Changes in AAPL Daily Prices over Last 5 Years",
        subtitle = "Qingxuan Chen") +
  theme(axis.text.x=element_blank())