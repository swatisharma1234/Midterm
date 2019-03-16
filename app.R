library(tidyverse)
library(shiny)
library(dplyr)

# reading in the dataset
data<- read.csv("C:/Users/swati/OneDrive - Emory University/Documents/Sem IV/550/MidTerm/Midterm/Data.csv", header = TRUE)
View(data)
colnames(data)

# Removing missing values form the dataset
data2<- data[(complete.cases(data)),]
nrow(data2)
data2<- as_tibble(data2)


server <- function(input, output) {
  
  output$plot_treatment<-renderPlot(
    
    ggplot(data=data2 %>% dplyr::filter(Moderate.Severe==input$Malnutrition_Type),
           aes(AgeGroup_M, Parent_Age_M_CI)) + 
      geom_point(color='red')+labs(title="", x="", y="")
    
      )
}

ui <- shinyUI(
  fluidPage(
    titlePanel("Substance Abuse Treatment Facilities"),
    fluidRow(
      selectInput("Malnutrition_Type", "Select Malnutrition Status", choices = unique(data2$Moderate.Severe)),
      plotOutput("plot_treatment")
    )
  )
)

shinyApp(ui = ui, server = server)