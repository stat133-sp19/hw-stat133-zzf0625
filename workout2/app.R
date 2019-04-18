library(shiny)
library(ggplot2)
library(tidyverse)
library(reshape2)

#' @title Future Value
#' @description calculates the future value of an investment with future value formula
#' @param amount present value amount (i.e. how much you invest)
#' @param rate annual rate of return
#' @param years time (in years)
#' @return computed future value

future_value <- function(amount = 1, rate = 1, years = 1){
  y <- amount*(1+rate)^years
  return(y)
}

#' @title Future Value of Annuity
#' @description calculates the future value of annuity of an investment with formula
#' @param contrib contributed amount(i.e. how much you deposit at the end of each year)
#' @param rate annual rate of return
#' @param years time (in years)
#' @return computed future value of annuity

annuity <- function(contrib = 1, rate = 1, years =1){
  a <- (1+rate)^years-1
  b <- contrib*(a/rate)
  return(b)
}

#' @title Future Value of Growing Annuity
#' @description calculates the future value of growing annuity of an investment with formula
#' @param contrib contributed amount(i.e. how much you deposit at the end of each year)
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years time (in years)
#' @return computed future value of growing annuity

growing_annuity <- function(contrib = 1, rate = 1, growth = 1, years = 1){
  a <- (1+rate)^years - (1+growth)^years
  b <- rate - growth
  c <- contrib*(a/b)
  return(c)
}

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving/Investing Scenarios"),
   
   # Sidebar with a slider input for number of bins 
   fluidRow(
     column(3,
            sliderInput("initial",
                        "Initial Amount",
                        min = 0,
                        max = 100000,
                        value = 1000,
                        step = 500,
                        pre = '$'),
            sliderInput('contrib',
                        'Annual Contribution',
                        min = 0,
                        max = 50000,
                        value = 2000,
                        step = 500,
                        pre = '$')),
     column(3,
            sliderInput('return',
                        'Return Rate (in %)',
                        min = 0,
                        max = 20,
                        value = 5,
                        step = 0.1,
                        post = '%'),
            sliderInput('growth',
                        'Growth Rate (in %)',
                        min = 0,
                        max = 20,
                        value = 2,
                        step = 0.1,
                        post = '%')),
     column(3, 
            sliderInput('year',
                        'Years',
                        min = 0,
                        max = 50,
                        value = 20,
                        step = 1),
            selectInput('facet',
                        'Facet?',
                        c('No', 'Yes'))
            
     ),
      
      # Show a plot of the generated distribution
     mainPanel(
       h3("Timelines"),
       plotOutput("timeline"),
       
       h3("Balances"),
       verbatimTextOutput("balance")
      )
   )
)

# Define server logic required to draw a plot
server <- function(input, output) {
  dat <- reactive({
      
    years <- input$year
    no <- rep(0, years)
    fixed <- rep(0, years)
    growing <- rep(0, years)
    rate <- input$return / 100
    
    for (i in 1:(years+1)) {
      no[i] <- future_value(amount = input$initial, rate, years = i-1)
      fixed[i] <- no[i] + annuity(contrib = input$contrib, rate, years = i-1)
      growing[i] <- no[i] + growing_annuity(contrib = input$contrib, rate, growth = input$growth/100, years = i-1) 
    }
    modalities <- data.frame("year" = 0:years, "no_contrib" = no, "fixed_contrib" = fixed, "growing_contrib" = growing)
    modalities                              
   })
    
    data <- reactive({
      data <- melt(dat(), id = "year")
      names(data) <- c("year", "modalities", "balance")
      return(data)
    })
  
  # Define output plot
  
  output$timeline <- renderPlot({
    non_facet <- ggplot(dat(), aes(x=year)) + 
      geom_line(aes(y=no_contrib, colour = "no_contrib"), size=0.5) + 
      geom_point(aes(y=no_contrib), colour = "red") + 
      geom_line(aes(y=fixed_contrib, colour = "fixed_contrib"), size=0.5) + 
      geom_point(aes(y=fixed_contrib), colour = "green") + 
      geom_line(aes(y=growing_contrib, colour = "growing_contrib"), size=0.5) + 
      geom_point(aes(y=growing_contrib), colour = "blue") + 
      ggtitle("Three Models of Investing") + 
      labs(x="Year", y="Future Value")+
      theme_light()+
      scale_x_continuous(breaks=seq(0,input$year,1))+
      scale_colour_manual(name="variable", values=c("no_contrib"="red", "fixed_contrib"="green" , "growing_contrib"="blue"))
    
    facet <- ggplot(data(), aes(x = year, y = balance, color = modalities)) +
      geom_area(aes(fill = modalities), alpha = 0.5, linetype = 0) +
      geom_line(size = 0.5) + 
      geom_point() + 
      ggtitle("Three modes of investing") + 
      labs(x="Year", y="Future Value") + 
      facet_grid(.~modalities) + 
      theme_light()+
      scale_colour_manual(name = "modalities", values = c(no_contrib="red", fixed_contrib="green", growing_contrib="blue"))
      
    if (input$facet == "Yes"){
      return(facet)
    }else{
      non_facet
    }
    
  })
  output$balance <- renderPrint({
    table <- dat()
    table
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

