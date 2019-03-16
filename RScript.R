# R code for Shinny App
# Since data has been loaded to the GitHub project folder
data<- read.csv("C:/Users/swati/OneDrive - Emory University/Documents/Sem IV/550/MidTerm/Midterm/Data.csv", header = TRUE)
View(data)
library(tidyverse)
library(dplyr)
colnames(data)
data2<- data[(complete.cases(data)),]
nrow(data2)
data2<- as_tibble(data2)

selectInput("Malnutrition_Type", "Select Malnutrition Status", choices = unique(data2$Moderate.Severe))
ggplot(data=data2 %>% dplyr::filter(Moderate.Severe==input$Malnutrition_Type),
       aes(A_PCT, number_living_household)) + 
  geom_point(stat ="Location")+labs(title="", x="", y="")
