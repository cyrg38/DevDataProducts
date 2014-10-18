library(shiny)
library(datasets)
data <- mtcars
data$cyl <- as.factor(data$cyl)
data$am <- as.factor(data$am)
data$vs <- as.factor(data$vs)
data$gear <- as.factor(data$gear)
data$carb <- as.factor(data$carb)
labels <- c("mpg" = "Miles/(US) gallon",
            "cyl" = "Number of cylinders",
            "disp" = "Displacement (cu.in.)",
            "hp" = "Gross horsepower",
            "drat" = "Rear axle ratio",
            "wt" = "Weight (lb/1000)",
            "qsec" = "1/4 mile time",
            "vs" = "V/S",
            "am" = "Transmission (0 = automatic, 1 = manual)",
            "gear" = "Number of forward gears",
            "carb" = "Number of carburetors")
liste <- names(labels)
names(liste) <- labels
# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Plotting with variable choice"),
  
  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("outcome", "Outcome:",
                liste[c(1,6,4,7)]),
    selectInput("regressor", "Regressor:",
                c(liste[-1], liste[1]))    
    #checkboxInput("outliers", "Show outliers", FALSE)
  ),
  
  # Show the caption and plot of the requested variable against mpg
  mainPanel(
    h3(textOutput("caption")),
    tabsetPanel(
      tabPanel("Plot", plotOutput("mpgPlot")), 
      tabPanel("Summary", verbatimTextOutput("formula")),
      tabPanel("Table", tableOutput("table"))
    )
  )
))