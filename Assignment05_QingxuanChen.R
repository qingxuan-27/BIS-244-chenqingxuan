#Assignment05 by Qingxuan
# Clean the Environment
rm(list=ls(all=TRUE))
cat("\014")

library(data.table)
library(tidyverse)
library(readxl)
library("ggplot2")
library("maps")

us_states <- map_data("state")
College01 <- read_excel("CollegeScorecardDataDictionary.xlsx", sheet=4) 
Data <- read_csv("most-recent-cohorts-all-data-elements-1.csv")


twodigitstates <- function(x) {
st.codes<-data.frame(
    state=as.factor(c("AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA",
                      "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME",
                      "MI", "MN", "MO", "MS",  "MT", "NC", "ND", "NE", "NH", "NJ", "NM",
                      "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN",
                      "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY")),
    fullname=as.factor(c("alaska","alabama","arkansas","arizona","california","colorado",
                     "connecticut","district of columbia","delaware","florida","georgia",
                     "hawaii","iowa","idaho","illinois","indiana","kansas","kentucky",
                     "louisiana","massachusetts","maryland","maine","michigan","minnesota",
                     "missouri","mississippi","montana","north carolina","north dakota",
                     "nebraska","new hampshire","new jersey","new mexico","nevada",
                     "new york","ohio","oklahoma","oregon","pennsylvania","puerto rico",
                     "rhode island","south carolina","south dakota","tennessee","texas",
                     "utah","virginia","vermont","washington","wisconsin",
                     "west virginia","wyoming"))
  )


st.x<-data.frame(state=x)
refac.x<-st.codes$full[match(st.x$state,st.codes$state)]
  return(refac.x)
  
}

Data$STABBRn<-twodigitstates(Data$STABBR)

Data1 <- Data %>% select(C150_4, STABBRn) %>% 
  mutate(C150_4 = as.numeric(C150_4)) %>% group_by(STABBRn) %>% 
  summarize(Percent_Completion = mean(C150_4, na.rm = TRUE)*100)


us_states <- left_join(us_states, Data1, 
                       by = c("region" = "STABBRn"))

# Make the graph
p <- ggplot(data = us_states,
            aes(x = long, y = lat,
                group = group, fill = Percent_Completion))

p + geom_polygon(color = "gray90", size = 0.1) + ggtitle(" Average Completion rate for first-time, full-time students 
at four-year institutions (150% of expected time to completion)")