library(tidyverse)
library(shiny)
library(dplyr)

# reading in the dataset
download.file("https://raw.githubusercontent.com/swatisharma1234/Midterm/master/shinydata.txt", destfile= "Data.csv", mode = "wb")
data1 = read.csv("Data.csv", header = TRUE)
#load("Data.csv")
data<- data1
colnames(data)

# Removing missing values form the dataset
data2<- data[(complete.cases(data)),]
nrow(data2)
data2<- as_tibble(data2)
#data2<- data2[order(-AgeGroup_M),]

server <- function(input, output) {
  
  output$plot_treatment<-renderPlot(
    
    ggplot(data=data2 %>% dplyr::filter(Moderate.Severe==input$Malnutrition_Type,sex==input$Gender),
           aes(Parent_AgeG, Age_M)) + 
      geom_point(color='red')+labs(title="Relationship between Age of Child and Parent", x="Age of Parent (years)", y="Age of Child (Months)")
    
  )
  
  output$plot_gender<- renderPlot(ggplot(data=data2 %>% dplyr::filter(Moderate.Severe==input$Malnutrition_Type,sex==input$Gender),
                                         aes(x=AgeGroup_M)) + geom_bar()+
                                    geom_text(stat='count',aes(label=..count..),vjust=-1))
  
}

ui <- shinyUI(
  fluidPage(
    tags$div(class="header", checked=NA,   tags$h1("Malnutrition and associated factors"),
             tags$head(tags$style("h1 {color: #104e8b; }"))
             
    ),
    
    sidebarLayout(
      #   
      # Sidebar panel for inputs ----
      sidebarPanel(
        selectInput("Malnutrition_Type", "Select Malnutrition Status", choices = unique(data2$Moderate.Severe)),
        selectInput("Gender", "Select Gender", choices = unique(data2$sex))
      ),
      
      
      # Main panel for displaying outputs ----
      mainPanel(
        
        # Output: 
        plotOutput("plot_treatment"),
        plotOutput("plot_gender")
        
        
      )
    )
  )
)

shinyApp(ui = ui, server = server)