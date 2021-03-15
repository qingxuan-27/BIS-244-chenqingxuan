Assignment 03 by Qingxuan

rm(list=ls(all=TRUE))
cat("\014")

library(tidyverse)

Temp <- getwd()

# Switching the working directory to the covid-19-data subfolder
setwd("./2020-elections-official/")

# Reading the us-states.csv in as a data frame
COUNTIES <- read_csv("PRESIDENT_precinct_general.csv")

setwd(Temp)

p <- ggplot(data = MONROE)
p + geom_point(mapping = aes(x = number, y = votes), color = "blue") +
  geom_point(mapping = aes(x = number, y = votes), color = "red") +
  labs(x = "Number",
       y = "Color",
       title = "2020 Elections Official") 
