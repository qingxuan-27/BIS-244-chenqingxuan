#Assignment04 by Qingxuan
#Clear the Console
rm(list=ls(all=TRUE))
cat("\014")

# Install and load packages
library(tidyverse)
if (!require("here")) install.packages("here")
if (!require("ggrepel")) install.packages("ggrepel")
library(here)
library(ggplot2)
library(ggrepel)

#Use non-PA data
data <- read_csv(here("covid-19-data","us-counties.csv"))
PA_1 <- subset(data, state=="Pennsylvania")
View(data)
View(PA_1)

# Use total cases and deaths
RESULTS1 <- PA_1[PA_1$date == max(PA_1$date),]

# Create visualization
Graph <- ggplot(data = RESULTS1, mapping = aes(x=cases, y=deaths,label=county))

Graph <- Graph + geom_point() + geom_smooth(method = "lm", se = FALSE) +
  geom_text_repel()
View(Graph)

ptitle <- paste("COVID-19 Deaths vs Cases for PA as of ", as.character(max(RESULTS1$date))," ")
xtitle <- "Cases"
ytitle <- "Deaths"
Graph <- Graph + labs(x=xtitle,y=ytitle,title=ptitle)
Graph