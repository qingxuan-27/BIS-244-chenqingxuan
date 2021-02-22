# Assignment 2

install.packages("tidyverse")

library(tidyverse)

install.packages("here")

library(here)

STATES <- read_csv(here("covid-19-data","us-states.csv"))

PA <- filter(STATES, state=="Pennsylvania")

n <- length(PA$date)

for (i in 1:n) {
  if (as.character(PA$date[i])=="2020-04-21") {
    PA$adj_deaths[i] <- (PA$deaths[i] - 282)
  } else if (as.character(PA$date[i])=="2020-04-22") {
    PA$adj_deaths[i] <- (PA$deaths[i] - 297)
  }
  else {PA$adj_deaths[i] <- PA$deaths[i]}
}

sum(PA$adj_deaths)
