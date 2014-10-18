library(shiny)
library(datasets)
data <- mtcars
data$cyl <- as.factor(data$cyl)
data$am <- as.factor(data$am)
data$vs <- as.factor(data$vs)
data$gear <- as.factor(data$gear)
data$carb <- as.factor(data$carb)
nms <- names(data)
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
# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  captionText <- reactive({
    paste0(labels[input$outcome], " ~ ", labels[input$regressor])
  })
  formulaText <- reactive({
    paste0(input$outcome, " ~ ", input$regressor)
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    captionText()
  })
  
  output$formula <- renderPrint({
    formulaText()
    regrline <- lm(as.formula(formulaText()), data = data)
    summary(regrline)
  })
  
  # Generate a plot of the requested variables 
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()),
        data = data, main= paste0("plotting ", captionText()),
        xlab = labels[input$regressor], ylab = labels[input$outcome])
    
    #impossible to do this work !
    #regrline <- lm(as.formula(formulaText()), data = data)
    #abline(lm(as.formula(formulaText(), data = data), col="red")
  })
  output$table <- renderTable({
    data.frame(mtcars[c(input$regressor, input$outcome)])
  })
})