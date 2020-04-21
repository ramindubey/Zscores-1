library(shiny)
library(plotly)
df <- read.csv(file = "combined_Zscores.csv", header = T, stringsAsFactors = F)
ui <- fluidPage(
  headerPanel('Scatter Plot for Z-scores'),
  sidebarPanel(
    selectInput('xcol','X Variable', names(df)),
    selectInput('ycol','Y Variable', names(df)),
    selected = names(df)[[2]]),
  mainPanel(
    plotlyOutput('plot')
  )
)

server <- function(input, output) {
  
  x <- reactive({
    df[,input$xcol]
  })
  
  y <- reactive({
    df[,input$ycol]
  })
  
  genes <- df[ ,c(1)]
  
  
  output$plot <- renderPlotly(
    plot1 <- plot_ly(
      x = x(),
      y = y(),
      text=c(genes),
      type = 'scatter',
      mode = 'markers')
  )
  
}

shinyApp(ui,server)