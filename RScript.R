# R code for Shinny App
# Since data has been loaded to the GitHub project folder
download.file("https://raw.githubusercontent.com/swatisharma1234/Midterm/master/Data.csv", destfile= "DataFile.csv", mode = "wb")
load("DataFile.csv")
data<- Data
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
