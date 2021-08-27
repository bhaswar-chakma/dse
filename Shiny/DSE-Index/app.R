#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)

# Define UI for application that draws line plot
ui <- fluidPage(

    # Application title
    titlePanel("DSE Indices"),

    # Sidebar with a slider input for years
    sidebarLayout(
        sliderInput("yearInput", "Year", min=1952, max=2007, step =5,
                    value=c(1928, 2011), sep=""),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("linePlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        df_indices <- readr::read_csv("./data/indices.csv")
        df_indices %>%
            mutate(Year = lubridate::year(Date)) %>%
            # Shiny input in action
            filter(year >= input$yearInput[1],
                   year <= input$yearInput[2])
            # ggplot
            ggplot(aes(x = Date, y = Close, color = Index)) +
            geom_line(size = 1.25) +
            facet_wrap(~ Index, nrow = 2, scale = "free") +
            theme_minimal() +
            labs(y = "", x = "")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
